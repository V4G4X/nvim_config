-- Initalize Calltree

function Calltree()
    -- configure the litee.nvim library
    require('litee.lib').setup()
    -- configure litee-calltree.nvim
    require('litee.calltree').setup({
        on_open = "popout",
        jump_mode = "invoking",
        no_hls = true,
    })

    -- Key maps
    require("which-key").add({
        { "<leader>lcI", vim.lsp.buf.incoming_calls,          desc = "Incoming Tree" },
        { "<leader>lcO", vim.lsp.buf.outgoing_calls,          desc = "Outgoing Tree" },
        { "<leader>lcP", require('litee.calltree').popout_to, desc = "Popout Call Tree" },
    })
end

if not vim.g.vscode then Calltree() end
