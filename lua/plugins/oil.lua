if not vim.g.vscode then
    return {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
        },
        opts = {},
        config = function(_, opts)
            require("oil").setup(opts)
        end,
    }
end

return {}
