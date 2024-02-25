-- Initalize Gen

function Gen()
    -- Key maps
    vim.keymap.set({ 'n', 'v' }, '<leader>G', ':Gen<CR>', { noremap = true, desc = "Gen" })
    require("which-key").register({
        G = { name = "Gen", ["1"] = "which_key_ignore" }, -- special label to hide it in the popup
    }, { prefix = "<leader>", mode = { "n", "v" } })

    require('gen').setup({
        model = "gemma:2b-instruct",
    })
end

if not vim.g.vscode then Gen() end
