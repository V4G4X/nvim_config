if not vim.g.vscode then
	return {
		"echasnovski/mini.cursorword",
		version = "*",
		config = function()
			require("mini.cursorword").setup()
		end,
	}
end

return {}
