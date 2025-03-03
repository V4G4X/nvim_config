return {
	"echasnovski/mini.move",
	version = "*",
	-- No need to copy this inside `setup()`. Will be used automatically.
	opts = {
		-- Module mappings. Use `''` (empty string) to disable one.
		mappings = {
			-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
			left = "<C-h>",
			right = "<C-l>",
			down = "<C-j>",
			up = "<C-k>",

			-- Move current line in Normal mode
			line_left = "<C-h>",
			line_right = "<C-l>",
			line_down = "<C-j>",
			line_up = "<C-k>",
		},

		-- Options which control moving behavior
		options = {
			-- Automatically reindent selection during linewise vertical move
			reindent_linewise = true,
		},
	},
	config = function(_, opts)
		require("mini.move").setup(opts)
	end,
}
