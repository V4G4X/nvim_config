-- Initialise BufferLine plugin

function InitBufferLine()
    require("bufferline").setup {
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
    }

    require("which-key").add({
        { "<leader>b",   group = "Buffers" },
        { "<leader>bN",  "<cmd>BufferLineCyclePrev<cr>",       desc = "Cycle Prev" },
        { "<leader>bb",  "<cmd>BufferLinePick<cr>",            desc = "Pick Buffer" },
        { "<leader>bc",  "<cmd>BufferLineCloseOthers<cr>",     desc = "Close other Buffers" },
        { "<leader>bd",  "<cmd>bdelete<cr>",                   desc = "Delete current buffer" },
        { "<leader>bn",  "<cmd>BufferLineCycleNext<cr>",       desc = "Cycle Next" },
        { "<leader>bp",  "<cmd>BufferLineTogglePin<cr>",       desc = "Toggle Pin" },
        { "<leader>bs",  group = "Sort Buffers" },
        { "<leader>bsd", "<cmd>BufferLineSortByDirectory<cr>", desc = "By Directory" },
    })
end

if not vim.g.vscode then InitBufferLine() end
