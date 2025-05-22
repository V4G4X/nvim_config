if not vim.g.vscode then
    return {
        'rmagatti/auto-session',
        opts = {
            log_level = "error",
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            bypass_save_filetypes = { 'startup', 'netrw', 'blank', 'snacks_dashboard', 'snacks_picker_input', 'Outline' },
        },
        config = function(_, opts)
            require("auto-session").setup(opts)
            vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
        end
    }
end

return {}
