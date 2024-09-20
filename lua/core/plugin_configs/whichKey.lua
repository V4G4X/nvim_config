-- Set General WhichKey Mappings

function SetGeneralWhichKeyMappings()
    local function copyRegisterToClipboard()
        local user_input = vim.fn.input("Register to yank to clipboard: ")
        vim.cmd("let @+=@" .. user_input)
    end

    -- Key maps
    local wk = require("which-key")
    wk.add({
        { "<leader>r",  group = "Registers" },
        { "<leader>ry", copyRegisterToClipboard, desc = "Yank register to clipboard" },
    })
end

if not vim.g.vscode then SetGeneralWhichKeyMappings() end
