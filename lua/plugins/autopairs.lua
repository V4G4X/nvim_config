if not vim.g.vscode then
	return {
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	}
end

return {}
