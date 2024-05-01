function InitAutoSessions()
    require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
    }
end

if not vim.g.vscode then InitAutoSessions() end
