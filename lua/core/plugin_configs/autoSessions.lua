function InitAutoSessions()
    require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        bypass_session_save_file_types = { 'startup' },
    }
end

if not vim.g.vscode then InitAutoSessions() end
