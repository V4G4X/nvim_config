if not vim.g.vscode then
    return {
        "LintaoAmons/easy-commands.nvim",
        event = "VeryLazy",
        config = function()
            require("easy-commands").setup({
                ---@type EasyCommand.Command[]
                myCommands = {
                    {
                        name = "ClearSessionAndQuit",
                        callback = function()
                            vim.cmd("SessionDelete")
                            vim.cmd("QuitNvim")
                        end,
                        description = "Clears the current Session before quitting",
                    },
                }
            })
        end,
    }
end

return {}
