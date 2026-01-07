if not vim.g.vscode then
	return {
		"milanglacier/minuet-ai.nvim",
		depedencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- Command to pin a file to minuet context (buffer-local)
			vim.api.nvim_create_user_command("MinuetPinContext", function(args)
				-- Convert to absolute path (handles ~, relative paths, etc.)
				local file = args.args
				local file_path = vim.fn.fnamemodify(file, ":p")

				if not vim.uv.fs_access(file_path, "r") then
					vim.notify("File not readable: " .. file_path, vim.log.levels.ERROR)
					return
				end

				vim.b.minuet_pin_context = {
					name = file,
					content = table.concat(vim.fn.readfile(file_path), "\n"),
				}
				vim.notify("Pinned: " .. file, vim.log.levels.INFO)
			end, {
				nargs = 1,
				complete = "file",
			})

			-- Command to clear pinned context
			vim.api.nvim_create_user_command("MinuetUnpinContext", function()
				vim.b.minuet_pin_context = nil
				vim.notify("Cleared pinned context", vim.log.levels.INFO)
			end, {})

			-- Command to show currently pinned file
			vim.api.nvim_create_user_command("MinuetShowPinned", function()
				if vim.b.minuet_pin_context then
					vim.notify("Pinned: " .. vim.b.minuet_pin_context.name, vim.log.levels.INFO)
				else
					vim.notify("No file pinned", vim.log.levels.INFO)
				end
			end, {})

			-- Prefix function that prepends pinned file content
			local function minuet_fim_prefix(context_before_cursor, _, _)
				local pin_context = ""

				if vim.b.minuet_pin_context then
					pin_context = vim.b.minuet_pin_context.content
				end

				if pin_context:match("%S") then
					pin_context = "<repo_context><filename>"
						.. vim.b.minuet_pin_context.name
						.. "</filename>"
						.. pin_context
						.. "\n</repo_context>\n\n# Context before cursor in current buffer begins\n"
				end

				return pin_context .. context_before_cursor
			end

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
							prompt = minuet_fim_prefix,
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

