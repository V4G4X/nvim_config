if not vim.g.vscode then
	local enabled = true
	local function toggle()
		enabled = not enabled
		require("smear_cursor").enabled = enabled
		if enabled then
			print("Smear enabled")
		else
			print("Smear disabled")
		end
	end
	return {
		"sphamba/smear-cursor.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>ts", toggle, desc = "Toggle Smear cursor" },
		},
	}
end

return {}
