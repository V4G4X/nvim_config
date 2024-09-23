return {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons", },
    version = "*",
    lazy = true,
    cmd = { "NvimTreeFocus", "NvimTreeToggle", "NvimTreeFindFile" },
    keys = {
        { "<leader>e",  "",                          desc = "Explorer" },
        { "<leader>ee", "<cmd>NvimTreeToggle<cr>",   desc = "Toggle" },
        { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Find File" },
    },
    config = function()
        -- disable netrw at the very start of your init.lua (strongly advised)
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        -- set termguicolors to enable highlight groups
        vim.opt.termguicolors = true

        local nvimTree = require("nvim-tree")
        nvimTree.setup({
            sort_by = "case_sensitive",
            view = {
                width = 30,
            },
            renderer = {
                group_empty = true,
            },
        })
    end,
}
