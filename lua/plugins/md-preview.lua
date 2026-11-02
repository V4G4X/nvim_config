if not vim.g.vscode then
	return {
		"selimacerbas/markdown-preview.nvim",
		-- Local fork carrying the mermaid bindFunctions patch (tooltips/hrefs
		-- from `click` statements). Drop `dir` once upstream merges it.
		dir = vim.fn.expand("~/playground/markdown-preview.nvim"),
		dependencies = { "selimacerbas/kitehost.nvim" },
		config = function()
			local mdkite = require("mdkite")
			mdkite.setup({
				-- all optional; sane defaults shown
				instance_mode = "multi", -- "takeover" (one tab) or "multi" (tab per instance)
				port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
				open_browser = true,
				debounce_ms = 300,
				hooks = {
					on_start = function(url)
						vim.notify("Preview started: " .. url, vim.log.levels.INFO)
					end,
					on_stop = function()
						vim.notify("Preview stopped", vim.log.levels.INFO)
					end,
				},
			})

			vim.keymap.set("n", "<leader>Pm", mdkite.toggle, { desc = "Toggle Markdown Preview" })
		end,
	}
end

return {}
