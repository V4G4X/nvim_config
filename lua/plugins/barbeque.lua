-- LSP Aware Win-Bar
if not vim.g.vscode then
	return {
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		config = function()
			require("barbecue").setup()
		end,
	}
end

return {}
