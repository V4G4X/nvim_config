function InitDap()
    local dap = require('dap')
    local dapui = require('dapui')

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

    local wk = require("which-key")
    wk.add({
        -- Debug mappings
        { "<leader>d",  group = "Debug" },
        { "<leader>dc", function() require('dap').continue() end, desc = "Continue" },
        { "<leader>do", function() require('dap').step_over() end, desc = "Step Over" },
        { "<leader>di", function() require('dap').step_into() end, desc = "Step Into" },
        { "<leader>dO", function() require('dap').step_out() end, desc = "Step Out" },
        { "<leader>db", function() require('dap').toggle_breakpoint() end, desc = "Toggle Breakpoint" },
        { "<leader>dB", function() require('dap').set_breakpoint() end, desc = "Set Breakpoint" },
        { "<leader>dp", function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "Set Log Point" },
        { "<leader>dr", function() require('dap').repl.open() end, desc = "Open REPL" },
        { "<leader>dl", function() require('dap').run_last() end, desc = "Run Last" },
        { "<leader>dh", function() require('dap.ui.widgets').hover() end, desc = "Hover" },
        { "<leader>dv", function() require('dap.ui.widgets').preview() end, desc = "Preview" },
        { "<leader>df", function() local widgets = require('dap.ui.widgets'); widgets.centered_float(widgets.frames) end, desc = "Show Frames" },
        { "<leader>ds", function() local widgets = require('dap.ui.widgets'); widgets.centered_float(widgets.scopes) end, desc = "Show Scopes" },
    })
end

if not vim.g.vscode then InitDap() end
