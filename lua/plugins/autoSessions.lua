return {
    'rmagatti/auto-session',
    opts = {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        bypass_session_save_file_types = { 'startup', 'netrw', 'blank' },
    },
    config = function(_, opts)
        require("auto-session").setup(opts)
        vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
}
