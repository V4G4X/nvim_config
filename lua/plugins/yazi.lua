if not vim.g.vscode then
    ---@type LazySpec
    return {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            {
                -- Open in the current working directory
                "<leader>y",
                "<cmd>Yazi cwd<cr>",
                desc = "Yazi File Manager",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            -- customize the keymaps that are active when yazi is open and focused. The
            -- defaults are listed below. Note that the keymaps simply hijack input and
            -- they are never sent to yazi, so only try to map keys that are never
            -- needed by yazi.
            --
            -- Also:
            -- - use e.g. `open_file_in_tab = false` to disable a keymap
            -- - you can customize only some of the keymaps (not all of them)
            -- - you can opt out of all keymaps by setting `keymaps = false`
            keymaps = {
                show_help = "<f1>",
                open_file_in_vertical_split = "<m-v>",
                open_file_in_horizontal_split = "<c-x>",
                open_file_in_tab = "<c-t>",
                grep_in_directory = "<c-s>",
                replace_in_directory = "<c-g>",
                cycle_open_buffers = "<tab>",
                copy_relative_path_to_selected_files = "<c-y>",
                send_to_quickfix_list = "<c-q>",
                change_working_directory = "<c-\\>",
            },
        },
    }
end

return {}
