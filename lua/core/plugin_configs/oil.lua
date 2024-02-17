-- Initialise Oil plugin

function InitOil()
    require("oil").setup()

    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
end

if not vim.g.vscode then InitOil() end
