if not vim.g.vscode then
    require('telescope').setup({
        defaults = {
            layout_strategy = 'vertical',
        },
    })
    local builtin = require('telescope.builtin')

    -- Key maps
    require("which-key").add({
        { "<leader>f",  group = "Telescope" },
        { "<leader>fG", builtin.git_files,             desc = "Git Files" },
        { "<leader>fH", builtin.help_tags,             desc = "Help Tags" },
        -- Trigger empty Telescope prompt with <leader>fT
        { "<leader>fT", "<cmd>Telescope<cr>",          desc = "Telescope Menu", remap = false },
        { "<leader>fb", builtin.buffers,               desc = "Buffers" },
        { "<leader>ff", builtin.find_files,            desc = "Find Files" },
        { "<leader>fg", builtin.live_grep,             desc = "Live Grep" },
        { "<leader>fp", "<cmd>Telescope commands<cr>", desc = "Commands",       remap = false },
    })
end
