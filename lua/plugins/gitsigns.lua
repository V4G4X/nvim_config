if not vim.g.vscode then
    return {
        "lewis6991/gitsigns.nvim",
        config = function()
            -- Add your gitsigns configuration here
            require('gitsigns').setup {
                signs                        = {
                    add          = { text = '│' },
                    change       = { text = '│' },
                    delete       = { text = '_' },
                    topdelete    = { text = '‾' },
                    changedelete = { text = '~' },
                    untracked    = { text = '┆' },
                },
                signcolumn                   = true, -- Toggle with `:Gitsigns toggle_signs`
                numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir                 = {
                    follow_files = true
                },
                attach_to_untracked          = true,
                current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts      = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 1000,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority                = 6,
                update_debounce              = 100,
                status_formatter             = nil, -- Use default
                max_file_length              = 40000, -- Disable if file is longer than this (in lines)
                preview_config               = {
                    -- Options passed to nvim_open_win
                    border = 'single',
                    style = 'minimal',
                    relative = 'cursor',
                    row = 0,
                    col = 1
                },
                on_attach                    = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    local next_hunk = function()
                        if vim.wo.diff then return ']c' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end

                    require("which-key").add({
                        { "]c", next_hunk, desc = "Next Hunk", expr = true, replace_keycodes = false },
                    })

                    local prev_hunk = function()
                        if vim.wo.diff then return '[c' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end

                    require("which-key").add({
                        { "[c", prev_hunk, desc = "Previous Hunk", expr = true, replace_keycodes = false },
                    }, { prefix = "[" })

                    -- Actions
                    require("which-key").add({
                        { "<leader>h",   group = "Hunk",                               mode = { "n", "v" } },
                        { "<leader>hD",  function() gs.diffthis('~') end,              desc = "Diff Buffer (HEAD)" },
                        { "<leader>hR",  gs.reset_buffer,                              desc = "Reset Buffer" },
                        { "<leader>hS",  gs.stage_buffer,                              desc = "Stage Buffer" },
                        { "<leader>hb",  function() gs.blame_line { full = true } end, desc = "Full Blame" },
                        { "<leader>hd",  gs.diffthis,                                  desc = "Diff Buffer" },
                        { "<leader>hp",  gs.preview_hunk,                              desc = "Preview Hunk" },
                        { "<leader>hr",  gs.reset_hunk,                                desc = "Reset Hunk" },
                        { "<leader>hs",  gs.stage_hunk,                                desc = "Stage Hunk" },
                        { "<leader>ht",  group = "Toggle" },
                        { "<leader>htb", gs.toggle_current_line_blame,                 desc = "Line Blame" },
                        { "<leader>htd", gs.toggle_deleted,                            desc = "Deleted" },
                        { "<leader>hu",  gs.undo_stage_hunk,                           desc = "Undo stage hunk" },
                        { "<leader>hv",  gs.select_hunk,                               desc = "Select Hunk" },
                    })

                    require("which-key").add({
                        { "<leader>hs", function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = "Stage Hunk", mode = "v" },
                        { "<leader>hr", function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, desc = "Reset Hunk", mode = "v" },
                    })
                end
            }
        end,
    }
end

return {}
