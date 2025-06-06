if not vim.g.vscode then
	return {
		"sphamba/smear-cursor.nvim",
		opts = { -- Default  Range
			time_interval = 7, -- 17 milliseconds
			stiffness = 0.8, -- 0.6      [0, 1]
			trailing_stiffness = 0.5, -- 0.4      [0, 1]
			stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
			trailing_stiffness_insert_mode = 0.6, -- 0.4      [0, 1]
			distance_stop_animating = 0.5, -- 0.1      > 0
		},
	}
end

return {}
