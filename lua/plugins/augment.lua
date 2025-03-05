if not vim.g.vscode then
	return {
		"augmentcode/augment.vim",
		config = function()
			vim.g.augment_workspace_folders = { "~/.config/nvim", "~/another-project" }

			vim.keymap.set({ "n", "v" }, "<leader>a", "", { desc = "Augment" })
			vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>Augment chat-toggle<cr>", { desc = "Toggle Chat" })
			vim.keymap.set("n", "<leader>as", "<cmd>Augment status<cr>", { desc = "Status" })
			vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>Augment chat<cr>", { desc = "Chat" })
			vim.keymap.set({ "n", "v" }, "<leader>an", "<cmd>Augment chat-new<cr>", { desc = "New Chat" })
		end,
	}
end

return {}
