if not vim.g.vscode then
    return {
        "rcarriga/nvim-notify",
        config = function()
            vim.keymap.set("n", "<leader>fn", require('telescope').extensions.notify.notify, { desc = "Notifications" })
            local notify = require('notify')
            notify.setup({
                background_colour = "#000000",
            })

            vim.notify = notify
        end,
    }
end

return {}
