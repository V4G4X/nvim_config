if not vim.g.vscode then
	return {
		"echasnovski/mini.pairs",
		version = "*",
		config = function()
			require("mini.pairs").setup()
		end,
	}
end

return {}
