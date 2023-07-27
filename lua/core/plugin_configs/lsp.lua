-- Initialise LSP plugin

function InitLspPlugin()
    local lsp = require('lsp-zero').preset({})

    lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
        local opts = { buffer = bufnr, remap = false }

        -- Key maps
        vim.keymap.set("n", "<C-]>", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>lsw", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>lsd", function() vim.lsp.buf.document_symbol() end, opts)
        vim.keymap.set("n", "<leader>l=", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end)


    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
end

if not vim.g.vscode then InitLspPlugin() end
