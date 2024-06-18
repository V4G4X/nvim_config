-- Initialise LSP Signature plugin
function InitLspSignature()
    require "lsp_signature".setup {}
end

if not vim.g.vscode then InitLspSignature() end
