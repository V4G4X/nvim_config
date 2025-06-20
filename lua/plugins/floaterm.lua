if not vim.g.vscode then
	return {
		"nvzone/floaterm",
		dependencies = "nvzone/volt",
		opts = {
			border = true,
			size = { h = 80, w = 80 },

			-- to use, make this func(buf)
			mappings = {
				sidebar = nil,
				term = function(buf)
					vim.keymap.set({ "n", "t" }, "<C-t>", function()
						vim.cmd("FloatermToggle")
					end, { buffer = buf })
					vim.keymap.set({ "n", "t" }, "<C-n>", function()
						require("floaterm.api").cycle_term_bufs("next")
					end, { buffer = buf })
					vim.keymap.set({ "n", "t" }, "<C-p>", function()
						require("floaterm.api").cycle_term_bufs("prev")
					end, { buffer = buf })
				end,
			},

			-- Default sets of terminals you'd like to open
			terminals = {
				{ name = "Terminal" },
				-- cmd can be function too
			},
		},
		cmd = "FloatermToggle",
		keys = {
			{ "<C-t>", "<cmd>FloatermToggle<cr>", desc = "Toggle FloaTerm" },
		},
	}
end

return {}
