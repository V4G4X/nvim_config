if not vim.g.vscode then
	return {
		"mfussenegger/nvim-dap",
		event = "VeryLazy",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Debug mappings
			vim.keymap.set("n", "<leader>d", "<nop>", { desc = "Debug" })
			vim.keymap.set("n", "<leader>dc", function()
				dap.continue()
			end, { desc = "Continue" })
			vim.keymap.set("n", "<leader>do", function()
				dap.step_over()
			end, { desc = "Step Over" })
			vim.keymap.set("n", "<leader>di", function()
				dap.step_into()
			end, { desc = "Step Into" })
			vim.keymap.set("n", "<leader>dO", function()
				dap.step_out()
			end, { desc = "Step Out" })
			vim.keymap.set("n", "<leader>db", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint()
			end, { desc = "Set Breakpoint" })
			vim.keymap.set("n", "<leader>dp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Set Log Point" })
			vim.keymap.set("n", "<leader>dr", function()
				dap.repl.open()
			end, { desc = "Open REPL" })
			vim.keymap.set("n", "<leader>dl", function()
				dap.run_last()
			end, { desc = "Run Last" })
			vim.keymap.set("n", "<leader>dh", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Hover" })
			vim.keymap.set("n", "<leader>dv", function()
				require("dap.ui.widgets").preview()
			end, { desc = "Preview" })
			vim.keymap.set("n", "<leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end, { desc = "Show Frames" })
			vim.keymap.set("n", "<leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end, { desc = "Show Scopes" })
		end,
	}
end

return {}
