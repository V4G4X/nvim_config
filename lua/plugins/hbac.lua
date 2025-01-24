-- Heuristic buffer auto-close
if not vim.g.vscode then
    return {
        'axkirillov/hbac.nvim',
        config = true
    }
end

return {}
