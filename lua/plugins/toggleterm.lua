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
			{ "<C-t>", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "Toggle Terminal" },
		},
	}
end

return {}
