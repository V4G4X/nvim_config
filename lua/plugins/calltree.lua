-- View Incoming/Outgoing Call Tree
return {

    {
        'ldelossa/litee-calltree.nvim',
        dependencies = {
            'ldelossa/litee.nvim',
            event = "VeryLazy",
            opts = {
                notify = { enabled = false },
                panel = {
                    orientation = "bottom",
                    panel_size = 10,
                },
            },
            config = function(_, opts) require('litee.lib').setup(opts) end
        },
        event = "VeryLazy",
        opts = {
            on_open = "popout",
            map_resize_keys = false,
            jump_mode = "invoking",
            no_hls = true,
        },
        config = function(_, opts)
            require('litee.calltree').setup(opts)

            -- Key maps
            vim.keymap.set("n", "<leader>lcI", vim.lsp.buf.incoming_calls, { desc = "Incoming Tree" })
            vim.keymap.set("n", "<leader>lcO", vim.lsp.buf.outgoing_calls, { desc = "Outgoing Tree" })
            vim.keymap.set("n", "<leader>lcP", require('litee.calltree').popout_to, { desc = "Popout Call Tree" })
        end
    }
}
