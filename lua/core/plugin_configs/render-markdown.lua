-- Initialise In-Buffer markdown render

function InitRenderMarkdown()
    require('render-markdown').setup({})
end

if not vim.g.vscode then InitRenderMarkdown() end
