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
		opts = {
			time_interval = 7, -- milliseconds
			stiffness = 0.8, -- 0.6      [0, 1]
			trailing_stiffness = 0.5, -- 0.4      [0, 1]
			stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
			trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
			damping = 0.8, -- 0.65     [0, 1]
			damping_insert_mode = 0.8, -- 0.7      [0, 1]
			distance_stop_animating = 0.5, -- 0.1      > 0
		},
		keys = {
			{ "<leader>ts", toggle, desc = "Toggle Smear cursor" },
		},
	}
end

return {}
