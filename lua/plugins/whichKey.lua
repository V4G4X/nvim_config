local function copyRegisterToClipboard()
    local user_input = vim.fn.input("Register to yank to clipboard: ")
    vim.cmd("let @+=@" .. user_input)
end

if not vim.g.vscode then
    return {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        keys = {
            { "<leader>r",  "",                      desc = "Registers" },
            { "<leader>t",  "",                      desc = "Toggles" },
            { "<leader>ry", copyRegisterToClipboard, desc = "Yank register to clipboard" },
        },
    }
end

return {}
