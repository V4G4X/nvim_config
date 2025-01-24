-- LSP Outline for Document
if not vim.g.vscode then
    return {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        opts = {},
        config = function(_, opts)
            require("outline").setup(opts)
        end,
    }
end

return {}
