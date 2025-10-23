if not vim.g.vscode then
	return {
		"milanglacier/minuet-ai.nvim",
		depedencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("minuet").setup({
				cmp = {
					enable_auto_complete = false,
				},
				blink = {
					enable_auto_complete = false,
				},
				virtualtext = {
					auto_trigger_ft = { "*" },
					keymap = {
						-- accept whole completion
						accept = "<S-Tab>",
						-- accept one line
						accept_line = "<A-a>",
						-- accept n lines (prompts for number)
						-- e.g. "A-z 2 CR" will accept 2 lines
						accept_n_lines = "<A-z>",
						-- Cycle to prev completion item, or manually invoke completion
						prev = "<A-[>",
						-- Cycle to next completion item, or manually invoke completion
						next = "<A-]>",
						dismiss = "<A-e>",
					},
				},
				provider = "codestral",
				provider_options = {
					codestral = {
						model = "codestral-latest",
						end_point = "https://codestral.mistral.ai/v1/fim/completions",
						api_key = "CODESTRAL_API_KEY",
						stream = true,
						template = {
							prompt = function(context_before_cursor, _, _)
								return context_before_cursor
							end,
							suffix = function(_, context_after_cursor, _)
								return context_after_cursor
							end,
						},
						optional = {
							max_tokens = 1024,
							stop = { "\n\n" },
						},
					},
				},
				-- Recommended settings for FIM
				n_completions = 3,
				context_window = 32000, -- Codestral 2508 supports large context
				debounce = 500,
				throttle = 1000,
				request_timeout = 5,
			})
		end,
	}
end

return {}
