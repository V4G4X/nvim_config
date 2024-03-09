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
    require("which-key").register({
        l = {
            c = {
                I = { vim.lsp.buf.incoming_calls, "Incoming Tree" },
                O = { vim.lsp.buf.outgoing_calls, "Outgoing Tree" },
                P = { require('litee.calltree').popout_to, "Popout Call Tree" },
            }
        },
    }, { prefix = "<leader>" })
end

if not vim.g.vscode then Calltree() end
