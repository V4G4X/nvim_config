-- Window Resize
if not vim.g.vscode then
    return {
        'nvim-focus/focus.nvim',
        version = '*',
        config = function()
            require('focus').setup()
        end
    }
end

return {}
