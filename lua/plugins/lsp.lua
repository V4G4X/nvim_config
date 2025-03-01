local function toggleInlayHints()
	if vim.fn.has("nvim-0.10") == 1 then
		local success, result = pcall(vim.lsp.inlay_hint.enable, not vim.lsp.inlay_hint.is_enabled())
		if not success then
			vim.notify("Failed to toggle inlay hints: " .. result, vim.log.levels.ERROR)
		end
	else
		vim.notify("Inlay hints require Neovim 0.10 or later", vim.log.levels.WARN)
	end
end

return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		{
			"folke/neoconf.nvim", -- Project level configurations (HAS TO BE BEFORE any LSP is set up)
			config = function()
				require("neoconf").setup()
			end,
		},
		-- LSP Support
		{
			"neovim/nvim-lspconfig",
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				require("lspconfig").gopls.setup({
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					single_file_support = true,
					settings = {
						gopls = {
							staticcheck = true,
							analyses = {
								unusedparams = true,
								unusedvariable = true,
								unusedwrite = true,
							},
							hints = {
								assignVariableTypes = true,
								compositeLiteralFields = true,
								compositeLiteralTypes = true,
								constantValues = true,
								parameterNames = true,
								rangeVariableTypes = true,
							},
						},
					},
				})
			end,
		}, -- Required
		{ -- Optional
			"williamboman/mason.nvim",
			build = function()
				pcall(vim.api.nvim_command, "MasonUpdate")
			end,
		},
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Formatting
		{
			"stevearc/conform.nvim", -- Replace null-ls for formatting
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				-- Configure conform.nvim for formatting
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						python = { "isort", "black" },
						go = { "goimports", "gofumpt" },
						javascript = { "prettier" },
						typescript = { "prettier" },
						typescriptreact = { "prettier" },
						javascriptreact = { "prettier" },
						json = { "prettier" },
						html = { "prettier" },
						css = { "prettier" },
						yaml = { "prettier" },
						markdown = { "prettier" },
					},
				})
			end,
		},

		-- Linting
		{
			"mfussenegger/nvim-lint", -- Replace null-ls for linting
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				-- Configure nvim-lint for linting
				local nvim_lint = require("lint")
				nvim_lint.linters_by_ft = {
					markdown = { "markdownlint" },
					yaml = { "yamllint" },
					gitcommit = { "gitlint" },
					-- Add other filetypes and linters as needed
				}
				-- Automatically run linters when reading or writing a buffer
				vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
					callback = function()
						nvim_lint.try_lint()
					end,
				})
			end,
		},

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "L3MON4D3/LuaSnip" }, -- Required
	},
	config = function()
		-- Enable inlay hints
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.server_capabilities.codeLensProvider then
					vim.lsp.codelens.refresh()
				end
				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true)
				end
				-- whatever other lsp config you want
			end,
		})

		local lspZero = require("lsp-zero").preset({})

		lspZero.on_attach(function(client, bufnr)
			lspZero.default_keymaps({ buffer = bufnr })
			local opts = { buffer = bufnr, remap = false }

			local telescopeBuiltin = require("telescope.builtin")

			-- Register groups
			vim.keymap.set("n", "<leader>l", "", { buffer = bufnr, desc = "LSP" })
			vim.keymap.set("n", "<leader>lT", "", { buffer = bufnr, desc = "Toggle" })
			vim.keymap.set("n", "<leader>lc", "", { buffer = bufnr, desc = "Calls" })
			vim.keymap.set("n", "<leader>ls", "", { buffer = bufnr, desc = "Symbols" })

			-- LSP keymaps using vim.keymap.set
			vim.keymap.set("n", "<leader>lA", vim.lsp.codelens.run, { buffer = bufnr, desc = "CodeLens Action" })
			vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename" })
			vim.keymap.set("n", "<leader>lS", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature" })
			vim.keymap.set("n", "<leader>lTh", toggleInlayHints, { buffer = bufnr, desc = "Toggle Inlay Hints" })
			vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })
			vim.keymap.set("v", "<leader>la", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Actions" })
			vim.keymap.set(
				"n",
				"<leader>lci",
				telescopeBuiltin.lsp_incoming_calls,
				{ buffer = bufnr, desc = "Incoming Calls" }
			)
			vim.keymap.set(
				"n",
				"<leader>lco",
				telescopeBuiltin.lsp_outgoing_calls,
				{ buffer = bufnr, desc = "Outgoing Calls" }
			)
			vim.keymap.set("n", "<leader>le", telescopeBuiltin.diagnostics, { buffer = bufnr, desc = "Diagnostics" })
			vim.keymap.set({ "n", "v" }, "<leader>lf", function()
				require("conform").format({ async = true })
			end, { buffer = bufnr, desc = "Format" })
			vim.keymap.set(
				"n",
				"<leader>li",
				telescopeBuiltin.lsp_implementations,
				{ buffer = bufnr, desc = "Implementations" }
			)
			vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = bufnr, desc = "References" })
			vim.keymap.set(
				"n",
				"<leader>lsd",
				telescopeBuiltin.lsp_document_symbols,
				{ buffer = bufnr, desc = "Document Symbols" }
			)
			vim.keymap.set(
				"n",
				"<leader>lsw",
				telescopeBuiltin.lsp_dynamic_workspace_symbols,
				{ buffer = bufnr, desc = "Workspace Symbols" }
			)
			vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { buffer = bufnr, desc = "Type Definition" })

			vim.diagnostic.config({
				virtual_lines = true,
				severity_sort = true,
			}) -- Don't display all diagnostics in the buffer
		end)

		-- (Optional) Configure lua language servers for neovim
		require("lspconfig").lua_ls.setup(lspZero.nvim_lua_ls())

		lspZero.setup()
	end,
}
