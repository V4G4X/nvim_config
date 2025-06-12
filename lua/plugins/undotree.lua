if not vim.g.vscode then
	return {
		"sanfusu/neovim-undotree",
		keys = {
			{ "<leader>tu", vim.cmd.UndotreeToggle, desc = "Undo Tree" },
		},
	}
end

return {}
