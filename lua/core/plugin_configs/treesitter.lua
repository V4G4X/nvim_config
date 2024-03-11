-- Initialise treesitter

function InitTS()
    require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "python", "scala", "java", "markdown", "yaml", "dockerfile" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        indent = {
            enable = true
        },

        highlight = {
            enable = true,

            -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
            -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
            -- the name of the parser)
            -- list of language that will be disabled
            -- disable = { "c", "rust" },
            -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },

        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                    ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                    ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                    ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                    ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                    ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                    ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                    ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                    ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                    ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                    ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                    ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                    ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                    ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                    ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                    ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                },
            },

            swap = {
                enable = true,
                swap_next = {
                    ["<leader>na"] = { query = "@parameter.inner", desc = "Argument/Parameter" }, -- swap parameters/argument with next
                    ["<leader>nm"] = { query = "@function.outer", desc = "Method/Function" },     -- swap function with next
                },
                swap_previous = {
                    ["<leader>pa"] = { query = "@parameter.inner", desc = "Argument/Parameter" }, -- swap parameters/argument with prev
                    ["<leader>pm"] = { query = "@function.outer", desc = "Method/Function" },     -- swap function with previous
                },
            },

            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]lf"] = { query = "@call.outer", desc = "Next function call start" },
                    ["]lm"] = { query = "@function.outer", desc = "Next method/function def start" },
                    ["]lc"] = { query = "@class.outer", desc = "Next class start" },
                    ["]li"] = { query = "@conditional.outer", desc = "Next conditional start" },
                    ["]ll"] = { query = "@loop.outer", desc = "Next loop start" },

                    -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                    -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                    -- ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                    ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                },
                goto_next_end = {
                    ["]lF"] = { query = "@call.outer", desc = "Next function call end" },
                    ["]lM"] = { query = "@function.outer", desc = "Next method/function def end" },
                    ["]lC"] = { query = "@class.outer", desc = "Next class end" },
                    ["]lI"] = { query = "@conditional.outer", desc = "Next conditional end" },
                    ["]lL"] = { query = "@loop.outer", desc = "Next loop end" },
                },
                goto_previous_start = {
                    ["[lf"] = { query = "@call.outer", desc = "Prev function call start" },
                    ["[lm"] = { query = "@function.outer", desc = "Prev method/function def start" },
                    ["[lc"] = { query = "@class.outer", desc = "Prev class start" },
                    ["[li"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                    ["[ll"] = { query = "@loop.outer", desc = "Prev loop start" },
                },
                goto_previous_end = {
                    ["[lF"] = { query = "@call.outer", desc = "Prev function call end" },
                    ["[lM"] = { query = "@function.outer", desc = "Prev method/function def end" },
                    ["[lC"] = { query = "@class.outer", desc = "Prev class end" },
                    ["[lI"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                    ["[lL"] = { query = "@loop.outer", desc = "Prev loop end" },
                },
            }
        },
    }

    local whichKey = require("which-key")
    whichKey.register({
        n = { name = "Swap Next", ["1"] = "which_key_ignore" }, -- special label to hide it in the popup
        p = { name = "Swap Prev", ["1"] = "which_key_ignore" }, -- special label to hide it in the popup
    }, { prefix = "<leader>" })
    whichKey.register({
        l = { name = "Lang Object", ["1"] = "which_key_ignore" }, -- special label to hide it in the popup
    }, { prefix = "]" })
    whichKey.register({
        l = { name = "Lang Object", ["1"] = "which_key_ignore" }, -- special label to hide it in the popup
    }, { prefix = "[" })

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move, { desc = "Repeat Move" })
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite, { desc = "Repeat Move Opposite" })

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
end

InitTS()
