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
						python = { "isort", "black" },
						go = { "goimports", "gofumpt" },
						javascript = { "prettier" },
						typescript = { "prettier" },
						typescriptreact = { "prettier" },
						javascriptreact = { "prettier" },
						json = { "prettier" },
						html = { "prettier" },
						css = { "prettier" },
						yaml = { "yamlfmt" },
						markdown = { "markdownlint" },
					},
				})
			end,
		},

		{ -- Linting
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
					"hrsh7th/nvim-cmp",
					dependencies = {
						"hrsh7th/cmp-nvim-lsp",
						"hrsh7th/cmp-nvim-lsp-signature-help",
					},
					config = function()
						-- Add additional capabilities supported by nvim-cmp
						local cmp = require("cmp")
						cmp.setup({
							sources = {
								{ name = "nvim_lsp" },
								{ name = "nvim_lsp_signature_help" },
							},
							snippet = {
								expand = function(args)
									-- You need Neovim v0.10 to use vim.snippet
									vim.snippet.expand(args.body)
								end,
							},
							mapping = cmp.mapping.preset.insert({}),
						})
					end,
				},
			},
			event = { "BufReadPre", "BufNewFile" },
			keys = {
				-- Register groups
				{ "<leader>l", "", desc = "LSP" },
				{ "<leader>lT", "", desc = "Toggle" },
				{ "<leader>lc", "", desc = "Calls" },
				{ "<leader>ls", "", desc = "Symbols" },
				{ "<leader>lTd", toggleVirtualLines, desc = "Toggle Diagnostic Lines" },
				{
					"<leader>lf",
					function()
						require("conform").format({ async = true })
					end,
					desc = "Format",
					mode = { "n", "v" },
				},
			},
			config = function()
				vim.api.nvim_create_autocmd("LspAttach", {
					desc = "LSP actions",
					callback = function(event)
						local telescopeBuiltin = require("telescope.builtin")

						-- LSP keymaps using vim.keymap.set
						vim.keymap.set("n", "<leader>lA", vim.lsp.codelens.run, { buffer = event.buf, desc = "CodeLens Action" })
						vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename" })
						vim.keymap.set("n", "<leader>lS", vim.lsp.buf.signature_help, { buffer = event.buf, desc = "Signature" })
						vim.keymap.set("n", "<leader>lTh", toggleInlayHints, { buffer = event.buf, desc = "Toggle Inlay Hints" })
						vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code Actions" })
						vim.keymap.set("v", "<leader>la", vim.lsp.buf.code_action, { buffer = event.buf, desc = "Code Actions" })
						vim.keymap.set("n", "<leader>lci", telescopeBuiltin.lsp_incoming_calls, { buffer = event.buf, desc = "Incoming Calls" })
						vim.keymap.set("n", "<leader>lco", telescopeBuiltin.lsp_outgoing_calls, { buffer = event.buf, desc = "Outgoing Calls" })
						vim.keymap.set("n", "<leader>le", telescopeBuiltin.diagnostics, { buffer = event.buf, desc = "Diagnostics" })
						vim.keymap.set("n", "<leader>li", telescopeBuiltin.lsp_implementations, { buffer = event.buf, desc = "Implementations" })
						vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = event.buf, desc = "References" })
						vim.keymap.set("n", "<leader>lsd", telescopeBuiltin.lsp_document_symbols, { buffer = event.buf, desc = "Document Symbols" })
						vim.keymap.set("n", "<leader>lsw", telescopeBuiltin.lsp_dynamic_workspace_symbols, { buffer = event.buf, desc = "Workspace Symbols" })
						vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { buffer = event.buf, desc = "Type Definition" })
					end,
				})

				-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
				local capabilities = require("cmp_nvim_lsp").default_capabilities()

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
						if client and client.server_capabilities.codeLensProvider then
							vim.lsp.codelens.refresh()
						end
						if client and client.server_capabilities.inlayHintProvider then
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
								globals = { "vim" }, -- Get the language server to recognize the `vim` global
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
