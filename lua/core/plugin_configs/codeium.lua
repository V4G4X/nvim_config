function ConfigureCodeium()
    vim.keymap.set('i', '<C-;>', function() return vim.fn['codeium#CycleCompletions'](1) end,
        { expr = true, silent = true, desc = "Next Suggestion" })
    vim.keymap.set('i', '<C-,>', function() return vim.fn['codeium#CycleCompletions'](-1) end,
        { expr = true, silent = true, desc = "Previous Suggestion" })
    vim.keymap.set('i', '<C-Bslash>', function() return vim.fn['codeium#Complete']() end,
        { expr = true, silent = true, desc = "Trigger Suggestion" })
    vim.keymap.set('i', '<C-]>', function() return vim.fn['codeium#Clear']() end,
        { expr = true, silent = true, desc = "Clear Suggestion" })
end

if not vim.g.vscode then ConfigureCodeium() end
