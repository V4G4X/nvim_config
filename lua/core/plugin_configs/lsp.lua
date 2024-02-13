-- Initialise LSP plugin

function InitLspPlugin()
    local lspZero = require('lsp-zero').preset({})

    lspZero.on_attach(function(client, bufnr)
        lspZero.default_keymaps({ buffer = bufnr })
        local opts = { buffer = bufnr, remap = false }

        -- Key maps
        vim.keymap.set("n", "<C-]>", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "<leader>lt", function() vim.lsp.buf.type_definition() end, opts)
        vim.keymap.set("n", "<leader>lh", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>lsw", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>lsd", function() vim.lsp.buf.document_symbol() end, opts)
        vim.keymap.set("n", "<leader>lf", function() vim.lsp.buf.format() end, opts)
        vim.keymap.set("n", "<leader>lr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>lR", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end)


    -- (Optional) Configure lua language servers for neovim
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup(lspZero.nvim_lua_ls())
    lspconfig.gopls.setup({
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        single_file_support = true,
        settings = {
            gopls = {
                gofumpt = true,
                staticcheck = true,
                usePlaceholders = true,
                analyses = {
                    unusedparams = true,
                }
            }
        },
    })

    -- (Optional) Integrate Language specific features applications
    local null_ls = require("null-ls")
    null_ls.setup({
        sources = {
            null_ls.builtins.formatting.goimports,
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.diagnostics.cfn_lint,
            null_ls.builtins.diagnostics.markdownlint,
            null_ls.builtins.completion.spell,
        },
    })

    lspZero.setup()
end

if not vim.g.vscode then InitLspPlugin() end
