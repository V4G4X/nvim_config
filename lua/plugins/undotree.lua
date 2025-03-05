if not vim.g.vscode then
	return {
		"sanfusu/neovim-undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Undo Tree" },
		},
	}
end

return {}
