if not vim.g.vscode then
	return {
		"supermaven-inc/supermaven-nvim",
		opts = {
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
				accept_word = "<C-j>",
			},
		},
		config = function(_, opts)
			require("supermaven-nvim").setup(opts)
		end,
	}
end

return {}
