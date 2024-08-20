-- Initialise Nvim Tree

function InitNvimTree()
    -- disable netrw at the very start of your init.lua (strongly advised)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- set termguicolors to enable highlight groups
    vim.opt.termguicolors = true

    -- OR setup with some options
    require("nvim-tree").setup({
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
    })

    local nvimTreeApi = require("nvim-tree.api")
    -- Key maps
    require("which-key").add({
        { "<leader>e", nvimTreeApi.tree.toggle, desc = "Explorer" },
    })
end

if not vim.g.vscode then InitNvimTree() end
