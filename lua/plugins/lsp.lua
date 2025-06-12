if not vim.g.vscode then
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

	-- Function to toggle virtual_lines in diagnostics
	local function toggleVirtualLines()
		-- Get current diagnostic config
		local current_config = vim.diagnostic.config()
		-- Toggle virtual_lines setting
		local new_virtual_lines = not current_config.virtual_lines
		-- Apply new config
		vim.diagnostic.config({ virtual_lines = new_virtual_lines })
		-- Notify user of the change
		vim.notify("Diagnostic virtual lines " .. (new_virtual_lines and "enabled" or "disabled"), vim.log.levels.INFO)
	end

	return {
		{ -- Install and delete LSPs, Linters and Formatters
			{
				"williamboman/mason.nvim",
				build = function()
					pcall(vim.api.nvim_command, "MasonUpdate")
				end,
				config = function()
					require("mason").setup()
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
		},

		{ -- Formatting
			"stevearc/conform.nvim", -- Replace null-ls for formatting
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				-- Configure conform.nvim for formatting
				require("conform").setup({
					formatters_by_ft = {
						lua = { "stylua" },
						python = { "ruff_format", "ruff_organize_imports" },
						go = { "goimports", "gofumpt" },
						javascript = { "prettier" },
						typescript = { "prettier" },
						typescriptreact = { "prettier" },
						javascriptreact = { "prettier" },
						json = { "fixjson" },
						html = { "prettier" },
						css = { "prettier" },
						yaml = { "yamlfmt" },
						markdown = { "mdformat" },
					},
				})
			end,
			keys = {
				{
					"<leader>lf",
					function()
						require("conform").format({ async = true })
					end,
					desc = "Format",
					mode = { "n", "v" },
				},
			},
		},

		{ -- Linting
			"mfussenegger/nvim-lint", -- Replace null-ls for linting
			event = { "BufReadPre", "BufNewFile" },
			config = function()
				-- Configure nvim-lint for linting
				local nvim_lint = require("lint")

				-- Fixes an issue with cfn_lint where it reports too many Ghost Diagnostics
				nvim_lint.linters.cfn_lint.stdin = false

				nvim_lint.linters_by_ft = {
					markdown = { "markdownlint" },
					yaml = { "yamllint" }, -- cfn_lint and spectral are enabled at Workspace level
					gitcommit = { "gitlint" },
					json = { "jsonlint" },
					-- Add other filetypes and linters as needed
				}
				-- Automatically run linters when reading or writing a buffer
				vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
					callback = function()
						nvim_lint.try_lint()
					end,
				})

				-- ── Session-local toggle for a single linter ─────────────────────────
				-- Ask user for a linter name; enable it if missing, disable if present
				local function toggle_linter(name)
					if not name or name == "" then
						return
					end
					local ft = vim.bo.filetype
					nvim_lint.linters_by_ft[ft] = nvim_lint.linters_by_ft[ft] or {}
					local linters = nvim_lint.linters_by_ft[ft]

					local found_idx
					for i, l in ipairs(linters) do
						if l == name then
							found_idx = i
							break
						end
					end

					if found_idx then
						table.remove(linters, found_idx)
						vim.notify("Disabled linter '" .. name .. "' for filetype '" .. ft .. "'")
						vim.diagnostic.reset(nvim_lint.get_namespace(name), 0) -- 0 = current buf
					else
						table.insert(linters, name)
						vim.notify("Enabled linter '" .. name .. "' for filetype '" .. ft .. "'")
						nvim_lint.try_lint()
					end
				end

				local function prompt_toggle_linter()
					local name = vim.fn.input("Linter to toggle: ")
					toggle_linter(name)
				end

				vim.keymap.set("n", "<leader>tl", prompt_toggle_linter, { desc = "Toggle linter by name", silent = true })
			end,
		},

		{ -- LSP Support
			"neovim/nvim-lspconfig",
			dependencies = {
				{
					"folke/neoconf.nvim", -- Project level configurations (HAS TO BE BEFORE any LSP is set up)
					config = function()
						require("neoconf").setup()
					end,
				},
				-- Autocompletion
				{
					-- Refer: https://cmp.saghen.dev/installation.html
					"saghen/blink.cmp",
					-- optional: provides snippets for the snippet source
					dependencies = { "rafamadriz/friendly-snippets" },

					version = "1.*",
					---@module 'blink.cmp'
					---@type blink.cmp.Config
					opts = {
						keymap = { preset = "default" },
						appearance = { nerd_font_variant = "mono" },
						completion = {
							accept = { auto_brackets = { enabled = true } }, -- Experimental auto-brackets support },
							documentation = { auto_show = true },
						},
						sources = {
							default = { "lsp", "path", "snippets", "buffer" },
						},
						fuzzy = { implementation = "prefer_rust_with_warning" },
						signature = { enabled = true },
					},
					opts_extend = { "sources.default" },
				},
			},
			event = { "BufReadPre", "BufNewFile" },
			keys = {
				-- Register groups
				{ "<leader>l", "", desc = "LSP" },
				{ "<leader>lc", "", desc = "Calls" },
				{ "<leader>ls", "", desc = "Symbols" },
				{ "<leader>td", toggleVirtualLines, desc = "Toggle Diagnostic Lines" },
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					desc = "LSP actions",
					callback = function(event)
						local telescopeBuiltin = require("telescope.builtin")
						local Snacks = require("snacks")

						-- LSP keymaps using vim.keymap.set
						vim.keymap.set("n", "<leader>lA", vim.lsp.codelens.run, { buffer = event.buf, desc = "CodeLens Action" })
						vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
						vim.keymap.set("n", "<leader>lS", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "Signature" })
						vim.keymap.set("n", "<leader>th", toggleInlayHints, { buffer = event.buf, desc = "Toggle Inlay Hints" })
						vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code Actions" })
						vim.keymap.set("n", "<leader>lci", telescopeBuiltin.lsp_incoming_calls, { buffer = event.buf, desc = "Incoming Calls" })
						vim.keymap.set("n", "<leader>lco", telescopeBuiltin.lsp_outgoing_calls, { buffer = event.buf, desc = "Outgoing Calls" })
						vim.keymap.set("n", "<leader>le", Snacks.picker.diagnostics, { buffer = event.buf, desc = "Diagnostics" })
						vim.keymap.set("n", "<leader>lE", Snacks.picker.diagnostics_buffer, { buffer = event.buf, desc = "Buffer Diagnostics" })
						vim.keymap.set("n", "<leader>li", Snacks.picker.lsp_implementations, { buffer = event.buf, desc = "Implementations" })
						vim.keymap.set("n", "<leader>lr", Snacks.picker.lsp_references, { buffer = event.buf, desc = "References" })
						vim.keymap.set("n", "<leader>lsd", Snacks.picker.lsp_symbols, { buffer = event.buf, desc = "Document Symbols" })
						vim.keymap.set("n", "<leader>lsw", Snacks.picker.lsp_workspace_symbols, { buffer = event.buf, desc = "Workspace Symbols" })
						vim.keymap.set("n", "<leader>lt", Snacks.picker.lsp_type_definitions, { buffer = event.buf, desc = "Type Definition" })
					end,
				})

				local capabilities = require("blink.cmp").get_lsp_capabilities()

				require("lspconfig").gopls.setup({
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					capabilities = capabilities,
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
				-- Enable inlay hints
				vim.api.nvim_create_autocmd("LspAttach", {
					group = vim.api.nvim_create_augroup("UserLspConfig", {}),
					callback = function(args)
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						if not client or not client.server_capabilities then
							-- If unable to get the client, or it's server_capabilities
							return
						end
						if client.server_capabilities.codeLensProvider then
							vim.lsp.codelens.refresh()
						end
						if client.server_capabilities.inlayHintProvider then
							vim.lsp.inlay_hint.enable(true)
						end
						-- whatever other lsp config you want
					end,
				})

				vim.lsp.config["luals"] = {
					-- Command and arguments to start the server.
					cmd = { "lua-language-server" },
					-- Filetypes to automatically attach to.
					filetypes = { "lua" },
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								disable = { "missing-fields" },
								globals = { "vim", "Snacks" }, -- Get the language server to recognize the `vim` global
							},
						},
					},
				}
				vim.lsp.enable("luals")

				require("lspconfig").yamlls.setup({
					capabilities = capabilities,
				})
				require("lspconfig").marksman.setup({
					capabilities = capabilities,
				})
				require("lspconfig").pyright.setup({
					capabilities = capabilities,
				})
			end,
		},
	}
end

return {}
