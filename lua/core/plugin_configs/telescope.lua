if not vim.g.vscode then
    local builtin = require('telescope.builtin')

    -- Key maps
    require("which-key").register({
        f = {
            name = "Telescope", -- optional group name
            f = { builtin.find_files, "Find Files" },
            g = { builtin.live_grep, "Live Grep" },
            b = { builtin.buffers, "Buffers" },
            H = { builtin.help_tags, "Help Tags" },
            G = { builtin.git_files, "Git Files" },
            -- Trigger empty Telescope prompt with <leader>fP
            P = { "<cmd>Telescope<cr>", "Telescope Menu", noremap = true, silent = true },
        },
    }, { prefix = "<leader>" })
end
