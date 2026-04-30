if not vim.g.vscode then
	return {
		"selimacerbas/markdown-preview.nvim",
		dependencies = { "selimacerbas/live-server.nvim" },
		config = function()
			require("markdown_preview").setup({
				-- all optional; sane defaults shown
				instance_mode = "takeover", -- "takeover" (one tab) or "multi" (tab per instance)
				port = 0, -- 0 = auto (8421 for takeover, OS-assigned for multi)
				open_browser = true,
				debounce_ms = 300,
			})

			local mp = require("markdown_preview")
			local function toggle_markdown_preview()
				if mp._server_instance ~= nil or mp._takeover_port ~= nil then
					mp.stop()
				else
					mp.start()
				end
			end

			vim.keymap.set("n", "<leader>Pm", toggle_markdown_preview, { desc = "Toggle Markdown Preview" })
		end,
	}
end

return {}
