if not vim.g.vscode then
	local function setupClaudeCode()
		local function is_claudecode_buffer(buf)
			-- Check multiple criteria
			local buf_name = vim.api.nvim_buf_get_name(buf)
			local buf_type = vim.bo[buf].buftype

			return buf_type == "terminal" and buf_name:match("claude")
		end

		-- Set up autocmds for detection
		vim.api.nvim_create_autocmd({ "TermOpen" }, {
			desc = "Advanced ClaudeCode buffer detection",
			callback = function(event)
				if is_claudecode_buffer(event.buf) then
					vim.keymap.set("t", "<C-t>", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude", buffer = event.buf, noremap = true, silent = true })
				end
			end,
		})
		return true
	end

	return {
		"coder/claudecode.nvim",
		config = setupClaudeCode(),
		keys = {
			{ "<leader>cc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
			{ "<leader>cf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
			{ "<leader>cr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
			{ "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
			{ "<leader>cs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
			{
				"<leader>cs",
				"<cmd>ClaudeCodeTreeAdd<cr>",
				desc = "Add file to Claude Code",
				ft = { "NvimTree", "neo-tree" },
			},
		},
	}
end

return {}
