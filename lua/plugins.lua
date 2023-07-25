return {
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }, -- Theme
    {
        "nvim-tree/nvim-tree.lua",                               -- Tree Explorer
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons", },
        config = function() require("nvim-tree").setup {} end,
    },
    { "tpope/vim-fugitive" }
}
