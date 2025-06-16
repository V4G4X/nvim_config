if not vim.g.vscode then
	return {
		"bezhermoso/tree-sitter-ghostty",
		build = "make nvim_install",
		event = "VeryLazy",
	}
end

return {}
