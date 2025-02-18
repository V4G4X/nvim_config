-- Initialise BufferLine plugin
return {
    'akinsho/bufferline.nvim',
    dependencies = 'nvim-tree/nvim-web-devicons',
    version = "*",
    opts = {
        options = {
            numbers = "ordinal",
            diagnostics = "nvim_lsp",
            offsets = {
                {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    highlight = "Directory",
                    separator = true -- use a "true" to enable the default, or set your own character
                },
            },
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)

        vim.keymap.set("n", "<leader>b", "", { desc = "Buffers" })
        vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
        vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
        vim.keymap.set("n", "<leader>bb", "<cmd>BufferLinePick<cr>", { desc = "Pick Buffer" })
        vim.keymap.set("n", "<leader>bc", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other Buffers" })
        vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete current buffer" })
        vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<cr>", { desc = "Toggle Pin" })
        vim.keymap.set("n", "<leader>bs", "", { desc = "Sort" })
        vim.keymap.set("n", "<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", { desc = "By Directory" })
    end,
}
