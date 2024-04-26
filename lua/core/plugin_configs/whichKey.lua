-- Set General WhichKey Mappings

function SetGeneralWhichKeyMappings()
    local function copyRegisterToClipboard()
        local user_input = vim.fn.input("Register to yank to clipboard: ")
        vim.cmd("let @+=@" .. user_input)
    end

    -- Key maps
    require("which-key").register({
        r = {
            name = "Registers", -- optional group name
            y = { copyRegisterToClipboard, "Yank register to clipboard" },
        },
    }, { prefix = "<leader>" })
end

if not vim.g.vscode then SetGeneralWhichKeyMappings() end
