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

    require("which-key").register({
        b = {
            name = "Buffers",
            b = { "<cmd>BufferLinePick<cr>", "Pick Buffer" },
            c = { "<cmd>BufferLineCloseOthers<cr>", "Close other Buffers" },
            n = { "<cmd>BufferLineCycleNext<cr>", "Cycle Next" },
            N = { "<cmd>BufferLineCyclePrev<cr>", "Cycle Prev" },
            p = { "<cmd>BufferLineTogglePin<cr>", "Toggle Pin" },
            s = {
                name = "Sort Buffers",
                d = { "<cmd>BufferLineSortByDirectory<cr>", "By Directory" },
            }
        },
    }, { prefix = "<leader>" })
end

if not vim.g.vscode then InitBufferLine() end
