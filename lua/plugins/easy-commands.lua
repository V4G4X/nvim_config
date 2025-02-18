if not vim.g.vscode then
    local function ClearSessionAndQuit()
        vim.cmd("SessionDelete")
        vim.cmd("QuitNvim")
    end

    return {
        "LintaoAmons/easy-commands.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>Q", ClearSessionAndQuit, desc = "Clear session and quit Neovim", mode = { "n" } },
        },
        config = function()
            require("easy-commands").setup({
                ---@type EasyCommand.Command[]
                myCommands = {
                    {
                        name = "ClearSessionAndQuit",
                        callback = ClearSessionAndQuit,
                        description = "Clears the current Session before quitting",
                    },
                }
            })
        end,
    }
end

return {}
