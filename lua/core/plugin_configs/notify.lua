-- Initialise Notify

function InitNotify()
    -- Key maps
    require("which-key").add({
        { "<leader>f",  group = "Telescope" },
        { "<leader>fn", require('telescope').extensions.notify.notify, desc = "Notifications" },
    })

    local notify = require('notify')
    notify.setup({
        background_colour = "#000000",
    })

    vim.notify = notify
end

if not vim.g.vscode then InitNotify() end
