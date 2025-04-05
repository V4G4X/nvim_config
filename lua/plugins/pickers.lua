if not vim.g.vscode then
	return {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
			branch = "0.1.x",
			config = function()
				require("telescope").setup({
					defaults = { layout_strategy = "vertical", },
				})
				-- Key maps
				vim.keymap.set("n", "<leader>fT", "<cmd>Telescope<cr>", { desc = "Telescope Menu" })
			end,
		},
	}
end

return {}
