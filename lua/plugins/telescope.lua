if not vim.g.vscode then
    return {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        branch = '0.1.x',
        config = function()
            require('telescope').setup({
                defaults = {
                    layout_strategy = 'vertical',
                },
            })
            local builtin = require('telescope.builtin')

            -- Key maps
            vim.keymap.set("n", "<leader>f", "", { desc = "Telescope" })
            vim.keymap.set("n", "<leader>fG", builtin.git_files, { desc = "Git Files" })
            vim.keymap.set("n", "<leader>fH", builtin.help_tags, { desc = "Help Tags" })
            vim.keymap.set("n", "<leader>fT", "<cmd>Telescope<cr>", { desc = "Telescope Menu" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
            vim.keymap.set("n", "<leader>fp", "<cmd>Telescope commands<cr>", { desc = "Commands" })
        end,
    }
end

return {}
