-- Initialise LazyGit plugin

function InitLazyGit()
    vim.keymap.set('n', '<leader>gg', ':LazyGit<CR>', { silent = true })
end

if not vim.g.vscode then InitLazyGit() end
