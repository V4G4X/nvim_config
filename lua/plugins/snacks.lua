if not vim.g.vscode then
	return {
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			picker = { layout = "bottom" },
			notifier = { enabled = true },
			image = { enabled = true },
			bigfile = { enabled = true },
			words = { enabled = true },
			dashboard = {
				enabled = function()
					-- Don't show dashboard for files in /var/folders/
					-- this is where ghostty's scrollback buffer in dumped
					local current_file = vim.fn.expand("%:p")
					return not current_file("%:p"):match("^/var/folders/")
				end,
				formats = {
					key = function(item)
						return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
					end,
				},
				sections = {
					{
						section = "terminal",
						cmd = "fortune -s 40% ~/.quotes/software 30% wisdom 30% humorists | cowsay -f sus -W 40",
						hl = "header",
						padding = 1,
						indent = 8,
						width = 50,
						height = 15,
						ttl = 0,
					},
					{ icon = " ", title = "Keymaps", section = "keys", indent = 4, padding = 1 },
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 4, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 4, padding = 1 },
					{ section = "startup" },
				},
			},
		},
        -- stylua: ignore
        keys = {
            -- Top Picker
            { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
            { "<leader>/",       function() Snacks.picker.grep() end, desc = "Grep" },
            { "<leader>N",       function() Snacks.notifier.show_history() end, desc = "Notification History" },
            -- find
            { "<leader>f",  "<nop>", desc = "Files" },
            { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
            { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
            { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
            { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
            { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
            { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
            -- git
            { "<leader>g",  "<nop>", desc = "Git", mode = { "n", "v" } },
            { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
            { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
            { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
            { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
            { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
            { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
            { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
            -- Grep
            { "<leader>sb", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
            { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
            { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
            { "<leader>sc", function() Snacks.picker.commands() end, desc = "Commands" },
            { "<leader>sC", function() Snacks.picker.command_history() end, desc = "Command History" },
            { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
            { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
            { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
            { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Quickfix List" },
            { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
            { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
            { "<leader>sT", function() Snacks.picker.colorschemes() end, desc = "Colorschemes (Themes)" },
            -- LSP
            { "gd",         function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
            { "gD",         function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
            { "gI",         function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
            { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
        },
		-- stylua: ignore end
	}
end
