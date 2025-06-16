if not vim.g.vscode then
	function CopyRegisterToClipboard()
		local user_input = vim.fn.input("Register to yank to clipboard: ")
		vim.cmd("let @+=@" .. user_input)
	end

	function ToggleQuickFix()
		local qf_exists = false
		for _, win in pairs(vim.fn.getwininfo()) do
			if win["quickfix"] == 1 then
				qf_exists = true
			end
		end
		if qf_exists == true then
			vim.cmd("cclose")
		else
			vim.cmd("copen")
		end
	end

	return {
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		keys = {
			{ "<leader>r", "<nop>", desc = "Registers" },
			-- Toggles section
			{ "<leader>t", "<nop>", desc = "Toggles" },
			{ "<leader>tq", ToggleQuickFix, desc = "Toggle quickfix" },
			-- Preview section
			{ "<leader>P", "<nop>", desc = "Preview" },
			{ "<leader>ry", CopyRegisterToClipboard, desc = "Yank register to clipboard" },
		},
	}
end

return {}
