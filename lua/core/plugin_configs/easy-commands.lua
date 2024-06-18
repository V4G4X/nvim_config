function EasyCommands()
    require("easy-commands").setup({
        myCommands = {
            {
                name = "ToggleScrollAnimation",
                callback = 'lua ToggleScrollAnimation()',
                description = "Toggle scrolling animation",
            },
        }
    })
end

if not vim.g.vscode then EasyCommands() end
