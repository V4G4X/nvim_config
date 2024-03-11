-- Initialise LSP plugin

function InitLspPlugin()
    local lspZero = require('lsp-zero').preset({})

    lspZero.on_attach(function(client, bufnr)
        lspZero.default_keymaps({ buffer = bufnr })
        local opts = { buffer = bufnr, remap = false }

        local telescopeBuiltin = require("telescope.builtin")

        -- Key maps
        require("which-key").register({
            l = {
                name = "LSP", -- optional group name
                a = { vim.lsp.buf.code_action, "Code Actions" },
                d = { vim.lsp.buf.definition, "Definition" },
                t = { vim.lsp.buf.type_definition, "Type Definition" },
                h = { vim.lsp.buf.hover, "Hover" },
                s = {
                    name = "Symbols",
                    w = { telescopeBuiltin.lsp_dynamic_workspace_symbols, "Workspace" },
                    d = { telescopeBuiltin.lsp_document_symbols, "Document" },
                },
                e = { telescopeBuiltin.diagnostics, "Diagnostics" },
                f = { vim.lsp.buf.format, "Format" },
                r = { vim.lsp.buf.references, "References" },
                R = { vim.lsp.buf.rename, "Rename" },
                i = { telescopeBuiltin.lsp_implementations, "Implementations" },
                c = {
                    name = "Calls",
                    i = { telescopeBuiltin.lsp_incoming_calls, "Incoming" },
                    o = { telescopeBuiltin.lsp_outgoing_calls, "Outgoing" },
                }
            },
        }, { prefix = "<leader>" })
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
                analyses = {
                    unusedparams = true,
                    unusedvariable = true,
                    unusedwrite = true,
                },
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
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

vim.keymap.set("n", "]g", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
