-- Initialise GitSigns

function InitGitSigns()
    require('gitsigns').setup {
        signs                        = {
            add          = { text = '│' },
            change       = { text = '│' },
            delete       = { text = '_' },
            topdelete    = { text = '‾' },
            changedelete = { text = '~' },
            untracked    = { text = '┆' },
        },
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
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
        status_formatter             = nil,   -- Use default
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

            require("which-key").register({
                c = { next_hunk, "Next Hunk", expr = true }
            }, { prefix = "]" })

            local prev_hunk = function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end

            require("which-key").register({
                c = { prev_hunk, "Previous Hunk", expr = true }
            }, { prefix = "[" })

            -- Actions
            require("which-key").register({
                h = {
                    name = "Hunk",
                    v = { gs.select_hunk, "Select Hunk" },
                    s = { gs.stage_hunk, "Stage Hunk" },
                    r = { gs.reset_hunk, "Reset Hunk" },
                    S = { gs.stage_buffer, "Stage Buffer" },
                    u = { gs.undo_stage_hunk, "Undo stage hunk" },
                    R = { gs.reset_buffer, "Reset Buffer" },
                    p = { gs.preview_hunk, "Preview Hunk" },
                    b = { function() gs.blame_line { full = true } end, "Full Blame" },
                    d = { gs.diffthis, "Diff Buffer" },
                    D = { function() gs.diffthis('~') end, "Diff Buffer (HEAD)" },
                    t = {
                        name = "Toggle",
                        b = { gs.toggle_current_line_blame, "Line Blame" },
                        d = { gs.toggle_deleted, "Deleted" },
                    },
                },
            }, { prefix = "<leader>" })

            require("which-key").register({
                hs = { function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Stage Hunk" },
                hr = { function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, "Reset Hunk" },
            }, { prefix = "<leader>", mode = "v" })
        end
    }
end

if not vim.g.vscode then InitGitSigns() end
