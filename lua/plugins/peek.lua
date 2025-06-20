if not vim.g.vscode then
	return {
		"toppair/peek.nvim",
		build = "deno task --quiet build:fast",
		opts = {
			auto_load = true, -- whether to automatically load preview when
			-- entering another markdown buffer
			close_on_bdelete = true, -- close preview window on buffer delete

			syntax = true, -- enable syntax highlighting, affects performance

			theme = "dark", -- 'dark' or 'light'

			update_on_change = true,

			app = "browser", -- 'webview', 'browser', string or a table of strings
			-- explained below

			filetype = { "markdown" }, -- list of filetypes to recognize as markdown

			-- relevant if update_on_change is true
			throttle_at = 200000, -- start throttling when file exceeds this
			-- amount of bytes in size
			throttle_time = "auto", -- minimum amount of time in milliseconds
			-- that has to pass before starting new render
		},
		config = function(_, opts)
			-- Store the current theme in a global variable so that it can be accessed
			-- from the toggle function. This makes sure we always know what the last
			-- chosen value was, even after re-loading Peek.
			_G.__peek_current_theme = opts.theme

			-- Global function that can be called from anywhere (mapping/command
			-- etc.) to toggle between the "dark" and "light" Peek themes.
			function _G.PeekToggleTheme()
				local is_open = require("peek").is_open()
				_G.__peek_current_theme = _G.__peek_current_theme == "dark" and "light" or "dark"
				require("peek").setup(vim.tbl_extend("force", opts, { theme = _G.__peek_current_theme }))
				if is_open then
					require("peek").close()
					require("peek").open()
					require("peek").open()
				end
			end
			require("peek").setup(opts)

			-- refer to `configuration to change defaults`
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
			-- Optional convenience command for toggling theme.
			vim.api.nvim_create_user_command("PeekToggleTheme", _G.PeekToggleTheme, { desc = "Toggle Peek Theme" })
		end,
		keys = {
			{ "<leader>Pm", "<cmd>PeekOpen<cr>", desc = "Preview Markdown" },
			{ "<leader>tm", "<cmd>PeekToggleTheme<cr>", desc = "Dark Mode for Peek" },
		},
	}
end

return {}
