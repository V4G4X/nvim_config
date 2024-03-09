return {
    { "catppuccin/nvim",                 name = "catppuccin",                                             priority = 1000 }, -- Theme
    {
        "nvim-tree/nvim-tree.lua",                                                                                           -- Tree Explorer
        version = "*",
        lazy = false,
        dependencies = { "nvim-tree/nvim-web-devicons", },
        config = function() require("nvim-tree").setup {} end,
    },
    { "tpope/vim-fugitive" },                                                                                              -- Git Tools
    { "nvim-lua/plenary.nvim" },                                                                                           -- Library of functions
    { 'nvim-telescope/telescope.nvim',   dependencies = { 'nvim-lua/plenary.nvim' },                      tag = '0.1.2' }, -- File Operations
    { "nvim-treesitter/nvim-treesitter", dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" } },               -- Parsers
    { "sanfusu/neovim-undotree" },                                                                                         -- UndoTree
    {
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
        }
    },
    { "scalameta/nvim-metals",     dependencies = { "mfussenegger/nvim-dap" } },                     -- Scala LSP
    { 'akinsho/toggleterm.nvim',   config = true,                                   version = "*" }, -- Toggelable terminal
    { "lewis6991/gitsigns.nvim" },                                                                   -- Git Signs (Gutter Indicators)
    { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },               -- Status Line
    { 'kevinhwang91/nvim-bqf' },                                                                     -- QuickFix window alternative
    { "kdheepak/lazygit.nvim",     dependencies = { "nvim-lua/plenary.nvim" } },                     -- LazyGit floating window
    -- { 'neoclide/coc.nvim',         branch = 'release' },                                             -- VS Code like LSP
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    { 'numToStr/Comment.nvim',          config = function() require "Comment".setup() end,                      lazy = false },  -- Adding Language aware Commenenting
    { 'akinsho/bufferline.nvim',        dependencies = 'nvim-tree/nvim-web-devicons',                           version = "*" }, -- bufferline adds Tabs to Buffers
    { "startup-nvim/startup.nvim",      config = function() require "startup".setup({ theme = "startify" }) end },               -- Startup Page
    { 'stevearc/oil.nvim',              dependencies = { "nvim-tree/nvim-web-devicons" },                       opts = {}, },    -- Manage Files in a Buffer-like editor
    { 'yorickpeterse/nvim-pqf',         config = function() require('pqf').setup() end, },                                       -- Formats the QuickFix window a little better
    { 'nvim-focus/focus.nvim',          config = function() require('focus').setup() end,                       version = '*' }, -- Window Resizer
    { 'stevearc/dressing.nvim',         opts = {} },                                                                             -- Improves the default Vim interfaces
    { 'rcarriga/nvim-notify' },                                                                                                  -- A better looking notification system
    { "LintaoAmons/easy-commands.nvim", event = "VeryLazy" },                                                                    -- A central interface to look up commands across plugins
    {
        'VonHeikemen/fine-cmdline.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>c', '<cmd>FineCmdline<CR>', { noremap = true, desc = "Command Line" })
        end
    },                                                                                                                                              -- Cool Command Line
    { "David-Kunz/gen.nvim" },                                                                                                                      -- Runs prompts for Ollama models
    { "vinnymeller/swagger-preview.nvim", build = "npm install -g swagger-ui-watcher" },                                                            -- Preview for Swagger Files
    { 'echasnovski/mini.nvim',            version = '*' },                                                                                          -- Animations
    { 'TabbyML/vim-tabby',                config = function() vim.g.tabby_keybinding_accept = '<Tab>' end },                                        -- Local Completion using HuggingFace models
    { "folke/trouble.nvim",               dependencies = { "nvim-tree/nvim-web-devicons" } },                                                       -- Pretty Diagnostics
    { "toppair/peek.nvim",                build = "deno task --quiet build:fast",                         event = { "VeryLazy" } },                 -- Markdown Preview
}
