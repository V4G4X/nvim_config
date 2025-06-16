if not vim.g.vscode then
	return {
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			direction = "float",
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
		end,
		keys = {
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
			-- Allow C-t only in Terminal mode for easy toggle-off
			{ "<C-t>", "<cmd>ToggleTerm<cr>", mode = "t", desc = "Toggle off Terminal" },
		},
	}
end

return {}
