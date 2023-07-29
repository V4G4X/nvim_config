if not vim.g.vscode then
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
    vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {})

    -- Trigger empty Telescope prompt with <leader>ff
    vim.keymap.set('n', '<leader>fP', [[<cmd>Telescope<CR>]], { noremap = true, silent = true })
end
