-- Contains color pallettes, backgrounds and other aesthetic overrides
function SetCatppuccinTheme()
	require("catppuccin").setup({
		-- require("after.plugins.catppuccin").setup({
		flavour = "mocha", -- latte, frappe, macchiato, mocha
		background = {
			-- :h background
			light = "latte",
			dark = "mocha",
		},
		transparent_background = true,
		show_end_of_buffer = false, -- show the '~' characters after the end of buffers
		term_colors = false,
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0,
		},
		no_italic = false, -- Force no italic
		no_bold = false, -- Force no bold
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
		},
		integrations = {
			cmp = true,
			gitsigns = true,
			nvimtree = true,
			telescope = true,
			-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
		},
	})

	-- setup must be called before loading
	vim.cmd.colorscheme "catppuccin"
	vim.cmd('hi LineNr guifg=#AAAAAA') -- Set Line Number coloring to be lighter than the theme default
end

if not vim.g.vscode then SetCatppuccinTheme() end
