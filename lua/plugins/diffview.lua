-- Diff View for Git Revisions
if not vim.g.vscode then
	local function diffOpenWithInput()
		local user_input = vim.fn.input("Revision to Open: ")
		vim.cmd("DiffviewOpen " .. user_input)
	end

	local function diffOpenFileHistory()
		local user_input = vim.fn.input("Files to Open: ")
		vim.cmd("DiffviewFileHistory" .. user_input)
	end

	return {
		"sindrets/diffview.nvim",
		keys = {
			{ "<leader>gf", diffOpenFileHistory, desc = "Open DiffView on Files" },
			{ "<leader>go", diffOpenWithInput, desc = "Open DiffView" },
		},
	}
end

return {}
