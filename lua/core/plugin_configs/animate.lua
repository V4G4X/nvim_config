-- Initialise MiniAnimate plugin

function InitMiniAnimate()
    require("mini.animate").setup {}
end

if not vim.g.vscode then InitMiniAnimate() end
