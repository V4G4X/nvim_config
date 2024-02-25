-- Initialise Notify

function InitNotify()
    -- Key maps
    require("which-key").register({
        f = {
            name = "Telescope", -- optional group name
            n = { require('telescope').extensions.notify.notify, "Notifications" },
        },
    }, { prefix = "<leader>" })

    local notify = require('notify')
    notify.setup({
        background_colour = "#000000",
    })

    vim.notify = notify
end

if not vim.g.vscode then InitNotify() end
