if not vim.g.vscode then
	local function ClearSessionAndQuit()
		-- Fix for race condition: SessionDelete + QuitNvim caused intermittent session restoration
		-- Create one-time listener for when session deletion completes
		vim.api.nvim_create_autocmd("User", {
			pattern = "CustomSessionCleared",
			once = true,
			callback = function()
				vim.cmd("QuitNvim")
			end,
		})

		-- Delete session, then signal completion via custom event in next event loop
		vim.cmd("SessionDelete")
		vim.schedule(function()
			vim.api.nvim_exec_autocmds("User", { pattern = "CustomSessionCleared" })
		end)
	end

	return {
		"LintaoAmons/easy-commands.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>Q", ClearSessionAndQuit, desc = "Clear session and quit Neovim", mode = { "n" } },
		},
		config = function()
			require("easy-commands").setup({
				---@type EasyCommand.Command[]
				myCommands = {
					{
						name = "ClearSessionAndQuit",
						callback = ClearSessionAndQuit,
						description = "Clears the current Session before quitting",
					},
				},
			})
		end,
	}
end

return {}
