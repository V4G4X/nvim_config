return {
    { "rebelot/kanagawa.nvim" },
    { "catppuccin/nvim",                 name = "catppuccin",                                             priority = 1000 },               -- Theme
    { "nvim-tree/nvim-tree.lua",         dependencies = { "nvim-tree/nvim-web-devicons", },               version = "*",    lazy = true }, -- Tree Explorer
    { "tpope/vim-fugitive" },                                                                                                              -- Git Tools
    { 'shumphrey/fugitive-gitlab.vim' },                                                                                                   -- Gitlab Blame Integration
    { 'tpope/vim-rhubarb' },
    { "nvim-lua/plenary.nvim" },                                                                                                           -- Library of functions
    { 'nvim-telescope/telescope.nvim',   dependencies = { 'nvim-lua/plenary.nvim' },                      branch = '0.1.x', },             -- File Operations
    { "nvim-treesitter/nvim-treesitter", dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" } },                               -- Parsers
    { "sanfusu/neovim-undotree" },                                                                                                         -- UndoTree
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
    { "scalameta/nvim-metals",   dependencies = { "mfussenegger/nvim-dap" } },               -- Scala LSP
    { 'akinsho/toggleterm.nvim', config = true,                             version = "*" }, -- Toggelable terminal
    { "lewis6991/gitsigns.nvim" },                                                           -- Git Signs (Gutter Indicators)
    { 'kevinhwang91/nvim-bqf' },                                                             -- QuickFix window alternative
    { "kdheepak/lazygit.nvim",   dependencies = { "nvim-lua/plenary.nvim" } },               -- LazyGit floating window
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
    { 'akinsho/bufferline.nvim',          dependencies = 'nvim-tree/nvim-web-devicons',                           version = "*" },          -- bufferline adds Tabs to Buffers
    { "startup-nvim/startup.nvim",        config = function() require "startup".setup({ theme = "startify" }) end },                        -- Startup Page
    { 'stevearc/oil.nvim',                dependencies = { "nvim-tree/nvim-web-devicons" },                       opts = {}, },             -- Manage Files in a Buffer-like editor
    { 'nvim-focus/focus.nvim',            config = function() require('focus').setup() end,                       version = '*' },          -- Window Resizer
    { 'stevearc/dressing.nvim',           opts = {} },                                                                                      -- Improves the default Vim interfaces
    { 'rcarriga/nvim-notify' },                                                                                                             -- A better looking notification system
    { "LintaoAmons/easy-commands.nvim",   event = "VeryLazy" },                                                                             -- A central interface to look up commands across plugins
    { "vinnymeller/swagger-preview.nvim", build = "npm install -g swagger-ui-watcher" },                                                    -- Preview for Swagger Files
    { 'echasnovski/mini.nvim',            version = '*' },                                                                                  -- Animations
    { "toppair/peek.nvim",                build = "deno task --quiet build:fast",                                 event = { "VeryLazy" } }, -- Markdown Preview
    { 'ldelossa/litee-calltree.nvim',     dependencies = { 'ldelossa/litee.nvim' } },                                                       -- View Incoming/Outgoing Call Tree
    { "chrisgrieser/nvim-spider",         lazy = true },                                                                                    -- Motion Traversal over SubWords
    { "sindrets/diffview.nvim" },                                                                                                           -- Diff View for Git Revisions
    { "jbyuki/venn.nvim" },                                                                                                                 -- ASCII Diagrams
    { "Exafunction/codeium.vim" },                                                                                                          -- Codeium Code Autocompletion
    {
        "utilyre/barbecue.nvim",                                                                                                            -- LSP Aware Win-Bar
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        config = function() require("barbecue").setup() end,
    },
    {
        "hedyhli/outline.nvim", -- LSP Outline for Document
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = { { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" }, },
        config = function() require("outline").setup() end,
    },
    { "sontungexpt/sttusline",               branch = "table_version", event = { "BufEnter" }, dependencies = { "nvim-tree/nvim-web-devicons" } }, -- Light Lazyloading StatusLine
    { "lukas-reineke/indent-blankline.nvim", main = "ibl" },                                                                                       -- Indentation Virtual Guides
    { 'rmagatti/auto-session' },                                                                                                                   -- Auto Session Management
    {
        "ray-x/lsp_signature.nvim",                                                                                                                -- Provides function signature while typing
        event = "VeryLazy",
        opts = {},
        config = function(_, opts) require 'lsp_signature'.setup(opts) end
    },
    { 'axkirillov/hbac.nvim', config = true },                                -- Heuristic buffer auto-close
}
