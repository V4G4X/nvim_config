local function toggleInlayHints()
    if vim.fn.has "nvim-0.10" == 1 then
        local success, result = pcall(vim.lsp.inlay_hint.enable, not vim.lsp.inlay_hint.is_enabled())
        if not success then
            vim.notify("Failed to toggle inlay hints: " .. result, vim.log.levels.ERROR)
        end
    else
        vim.notify("Inlay hints require Neovim 0.10 or later", vim.log.levels.WARN)
    end
end

return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' }, -- Required
        {                            -- Optional
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.api.nvim_command, 'MasonUpdate')
            end,
        },
        { 'williamboman/mason-lspconfig.nvim' }, -- Optional
        { 'nvimtools/none-ls.nvim' },            -- Optional
        -- Autocompletion
        { 'hrsh7th/nvim-cmp' },                  -- Required
        { 'hrsh7th/cmp-nvim-lsp' },              -- Required
        { 'L3MON4D3/LuaSnip' },                  -- Required
        { "folke/neoconf.nvim" }                 -- Project level configurations
    },
    config = function()
        -- Enable inlay hints
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client and client.server_capabilities.codeLensProvider then
                    vim.lsp.codelens.refresh()
                end
                if client and client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true)
                end
                -- whatever other lsp config you want
            end
        })

        local lspZero = require('lsp-zero').preset({})

        lspZero.on_attach(function(client, bufnr)
            lspZero.default_keymaps({ buffer = bufnr })
            local opts = { buffer = bufnr, remap = false }

            local telescopeBuiltin = require("telescope.builtin")

            require("which-key").add({
                { "<leader>l",   group = "LSP" },
                { "<leader>lA",  vim.lsp.codelens.run,                                desc = "CodeLens Action" },
                { "<leader>lR",  vim.lsp.buf.rename,                                  desc = "Rename" },
                { "<leader>lT",  group = "Toggle" },
                { "<leader>lTh", toggleInlayHints,                                    desc = "Toggle Inlay Hints" },
                { "<leader>la",  vim.lsp.buf.code_action,                             desc = "Code Actions",      mode = { "n", "v" } },
                { "<leader>lc",  group = "Calls" },
                { "<leader>lci", telescopeBuiltin.lsp_incoming_calls,                 desc = "Incoming" },
                { "<leader>lco", telescopeBuiltin.lsp_outgoing_calls,                 desc = "Outgoing" },
                { "<leader>le",  telescopeBuiltin.diagnostics,                        desc = "Diagnostics" },
                { "<leader>lf",  function() vim.lsp.buf.format({ async = true }) end, desc = "Format" },
                { "<leader>li",  telescopeBuiltin.lsp_implementations,                desc = "Implementations" },
                { "<leader>lr",  vim.lsp.buf.references,                              desc = "References" },
                { "<leader>ls",  group = "Symbols" },
                { "<leader>lsd", telescopeBuiltin.lsp_document_symbols,               desc = "Document" },
                { "<leader>lsw", telescopeBuiltin.lsp_dynamic_workspace_symbols,      desc = "Workspace" },
                { "<leader>lt",  vim.lsp.buf.type_definition,                         desc = "Type Definition" },
            })

            vim.diagnostic.config({ virtual_text = false }) -- Don't display all diagnostics in the buffer
        end)


        require("neoconf").setup({
            -- override any of the default settings here
        })

        -- (Optional) Configure lua language servers for neovim
        local lspconfig = require('lspconfig')

        lspconfig.lua_ls.setup(lspZero.nvim_lua_ls())

        lspconfig.gopls.setup({
            cmd = { "gopls" },
            filetypes = { "go", "gomod", "gowork", "gotmpl" },
            single_file_support = true,
            settings = {
                gopls = {
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
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
                null_ls.builtins.formatting.goimports,
                null_ls.builtins.formatting.prettier,
                null_ls.builtins.diagnostics.cfn_lint,
                null_ls.builtins.diagnostics.markdownlint,
                null_ls.builtins.completion.spell,
            },
        })

        lspZero.setup()
    end,
}
