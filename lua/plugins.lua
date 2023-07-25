return {
	{ "catppuccin/nvim",                name = "catppuccin", priority = 1000 }, -- Theme
	{
		"nvim-tree/nvim-tree.lua",                                   -- Tree Explorer
		version = "*",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons", },
		config = function() require("nvim-tree").setup {} end,
	},
	{ "tpope/vim-fugitive" },                                                                       -- Git Tools
	{ "nvim-lua/plenary.nvim" },                                                                    -- Library of functions
	{ 'nvim-telescope/telescope.nvim',  tag = '0.1.2',       dependencies = { 'nvim-lua/plenary.nvim' } }, -- File Operations
	{ "nvim-treesitter/nvim-treesitter" },                                                          -- Parsers
	{ "sanfusu/neovim-undotree" },                                                                  -- UndoTree
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		dependencies = {
			-- LSP Support
			{ 'neovim/nvim-lspconfig' }, -- Required
			{       -- Optional
				'williamboman/mason.nvim',
				build = function()
					pcall(vim.api.nvim_command, 'MasonUpdate')
				end,
			},
			{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

			-- Autocompletion
			{ 'hrsh7th/nvim-cmp' }, -- Required
			{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
			{ 'L3MON4D3/LuaSnip' }, -- Required
		}
	},
	{ "scalameta/nvim-metals",     dependencies = { "mfussenegger/nvim-dap" } },              -- Scala LSP
	{ 'akinsho/toggleterm.nvim',   version = "*",                                   config = true }, -- Toggelable terminal
	{ "lewis6991/gitsigns.nvim" },                                                            -- Git Signs (Gutter Indicators)
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },        -- Status Line
}
