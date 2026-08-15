-- nvim-treesitter `main` branch (the full rewrite).
--
-- The rewrite only installs parsers/queries; highlighting, indentation and
-- folding are now Neovim features that have to be switched on per buffer, and
-- text objects moved into their own `setup` + explicit keymaps. See
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/README.md

local ensure_installed = {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"go",
	"python",
	"scala",
	"java",
	"markdown",
	"markdown_inline",
	"yaml",
	"dockerfile",
	"regex",
	"css",
	"javascript",
	"scss",
	"svelte",
	"tsx",
	"typst",
	"vue",
}

local MAX_FILESIZE = 100 * 1024 -- 100 KB

---@param bufnr integer
---@return boolean
local function is_large_file(bufnr)
	local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	return ok and stats ~= nil and stats.size > MAX_FILESIZE
end

--- Enable highlighting and indentation for a buffer.
---@param bufnr integer
local function enable_features(bufnr)
	if not vim.api.nvim_buf_is_valid(bufnr) then
		return
	end
	if is_large_file(bufnr) then
		return
	end
	if not pcall(vim.treesitter.start, bufnr) then
		return
	end
	vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

--- Replacement for the old `auto_install`: install the parser for this
--- filetype on demand, then start treesitter once it lands.
---@param bufnr integer
---@param filetype string
local function start_or_install(bufnr, filetype)
	local lang = vim.treesitter.language.get_lang(filetype)
	if not lang then
		return
	end

	local ts = require("nvim-treesitter")
	if vim.list_contains(ts.get_installed("parsers"), lang) then
		enable_features(bufnr)
		return
	end

	if not vim.list_contains(ts.get_available(), lang) then
		return
	end

	ts.install(lang):await(function()
		vim.schedule(function()
			enable_features(bufnr)
		end)
	end)
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		-- The rewrite explicitly does not support lazy-loading.
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({})
			require("nvim-treesitter").install(ensure_installed)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
				callback = function(args)
					start_or_install(args.buf, args.match)
				end,
			})

			local incremental = require("core.ts_incremental_selection")
			vim.keymap.set("n", "<C-space>", incremental.init_selection, { desc = "Init Selection" })
			vim.keymap.set("x", "<C-space>", incremental.node_incremental, { desc = "Increment Selection" })
			vim.keymap.set("x", "<bs>", incremental.node_decremental, { desc = "Decrement Selection" })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
				},
				move = {
					set_jumps = true, -- whether to set jumps in the jumplist
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			local swap = require("nvim-treesitter-textobjects.swap")
			local move = require("nvim-treesitter-textobjects.move")

			---@param lhs string
			---@param query string
			---@param desc string
			local function map_select(lhs, query, desc)
				vim.keymap.set({ "x", "o" }, lhs, function()
					select.select_textobject(query, "textobjects")
				end, { desc = desc })
			end

			---@param lhs string
			---@param fn fun(query: string, group: string)
			---@param query string
			---@param desc string
			---@param group? string
			local function map_move(lhs, fn, query, desc, group)
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					fn(query, group or "textobjects")
				end, { desc = desc })
			end

			-- Capture groups are defined in `textobjects.scm`
			map_select("a=", "@assignment.outer", "Select outer part of an assignment")
			map_select("i=", "@assignment.inner", "Select inner part of an assignment")
			map_select("l=", "@assignment.lhs", "Select left hand side of an assignment")
			map_select("r=", "@assignment.rhs", "Select right hand side of an assignment")

			map_select("aa", "@parameter.outer", "Select outer part of a parameter/argument")
			map_select("ia", "@parameter.inner", "Select inner part of a parameter/argument")

			map_select("ai", "@conditional.outer", "Select outer part of a conditional")
			map_select("ii", "@conditional.inner", "Select inner part of a conditional")

			map_select("al", "@loop.outer", "Select outer part of a loop")
			map_select("il", "@loop.inner", "Select inner part of a loop")

			map_select("af", "@call.outer", "Select outer part of a function call")
			map_select("if", "@call.inner", "Select inner part of a function call")

			map_select("am", "@function.outer", "Select outer part of a method/function definition")
			map_select("im", "@function.inner", "Select inner part of a method/function definition")

			map_select("ac", "@class.outer", "Select outer part of a class")
			map_select("ic", "@class.inner", "Select inner part of a class")

			vim.keymap.set("n", "<leader>n", "", { desc = "Swap Next" })
			vim.keymap.set("n", "<leader>p", "", { desc = "Swap Prev" })
			vim.keymap.set("n", "]l", "", { desc = "Lang Object" })
			vim.keymap.set("n", "[l", "", { desc = "Lang Object" })

			vim.keymap.set("n", "<leader>na", function()
				swap.swap_next("@parameter.inner")
			end, { desc = "Argument/Parameter" })
			vim.keymap.set("n", "<leader>nm", function()
				swap.swap_next("@function.outer")
			end, { desc = "Method/Function" })
			vim.keymap.set("n", "<leader>pa", function()
				swap.swap_previous("@parameter.inner")
			end, { desc = "Argument/Parameter" })
			vim.keymap.set("n", "<leader>pm", function()
				swap.swap_previous("@function.outer")
			end, { desc = "Method/Function" })

			map_move("]lf", move.goto_next_start, "@call.outer", "Next function call start")
			map_move("]lm", move.goto_next_start, "@function.outer", "Next method/function def start")
			map_move("]lc", move.goto_next_start, "@class.outer", "Next class start")
			map_move("]li", move.goto_next_start, "@conditional.outer", "Next conditional start")
			map_move("]ll", move.goto_next_start, "@loop.outer", "Next loop start")
			map_move("]z", move.goto_next_start, "@fold", "Next fold", "folds")

			map_move("]lF", move.goto_next_end, "@call.outer", "Next function call end")
			map_move("]lM", move.goto_next_end, "@function.outer", "Next method/function def end")
			map_move("]lC", move.goto_next_end, "@class.outer", "Next class end")
			map_move("]lI", move.goto_next_end, "@conditional.outer", "Next conditional end")
			map_move("]lL", move.goto_next_end, "@loop.outer", "Next loop end")

			map_move("[lf", move.goto_previous_start, "@call.outer", "Prev function call start")
			map_move("[lm", move.goto_previous_start, "@function.outer", "Prev method/function def start")
			map_move("[lc", move.goto_previous_start, "@class.outer", "Prev class start")
			map_move("[li", move.goto_previous_start, "@conditional.outer", "Prev conditional start")
			map_move("[ll", move.goto_previous_start, "@loop.outer", "Prev loop start")

			map_move("[lF", move.goto_previous_end, "@call.outer", "Prev function call end")
			map_move("[lM", move.goto_previous_end, "@function.outer", "Prev method/function def end")
			map_move("[lC", move.goto_previous_end, "@class.outer", "Prev class end")
			map_move("[lI", move.goto_previous_end, "@conditional.outer", "Prev conditional end")
			map_move("[lL", move.goto_previous_end, "@loop.outer", "Prev loop end")

			local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

			-- vim way: ; goes to the direction you were moving.
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, { desc = "Repeat Move" })
			vim.keymap.set(
				{ "n", "x", "o" },
				",",
				ts_repeat_move.repeat_last_move_opposite,
				{ desc = "Repeat Move Opposite" }
			)

			-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
