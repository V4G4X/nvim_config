-- Initialise ToggleTree

function InitToggleTerm()
    require("toggleterm").setup({
        open_mapping = '<c-t>',
        direction = "float",
    })

    -- vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
end

if not vim.g.vscode then InitToggleTerm() end
