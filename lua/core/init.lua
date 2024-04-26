-- Plugins (and themes)
require("core.plugin_configs")

if not vim.g.vscode then SetKanagawaTheme() end

-- Nvim Settings
require("core.settings")

-- Gitlab Configuration
require("core.gitlab")
