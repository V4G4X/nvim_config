-- QuickFix window alternative
if not vim.g.vscode then
	return {
		"kevinhwang91/nvim-bqf",
		event = "VeryLazy",
	}
end

return {}
