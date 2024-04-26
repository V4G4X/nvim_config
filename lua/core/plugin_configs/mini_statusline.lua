-- Initialises the mini.statusline plugin

function InitMiniStatusline()
    require('mini.statusline').setup()
end

if not vim.g.vscode then InitMiniStatusline() end
