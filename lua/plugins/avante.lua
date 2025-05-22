if not vim.g.vscode then
	return {
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "bedrock" | string
			provider = "perplexity",
			vendors = {
				openrouter_sonnet = {
					__inherited_from = "openai",
					api_key_name = "OPENROUTER_API_KEY",
					endpoint = "https://openrouter.ai/api/v1/",
					model = "anthropic/claude-sonnet-4",
				},
				openrouter_flash = {
					__inherited_from = "openai",
					api_key_name = "OPENROUTER_API_KEY",
					endpoint = "https://openrouter.ai/api/v1/",
					model = "google/gemini-2.5-pro-preview",
				},
				perplexity = {
					__inherited_from = "openai",
					api_key_name = "PERPLEXITY_API_KEY",
					endpoint = "https://api.perplexity.ai",
					model = "r1-1776",
				},
			},
			bedrock = {
				model = "us.anthropic.claude-sonnet-4-20250514-v1:0",
				aws_profile = "default",
				aws_region = "us-east-1",
			},
			behaviour = {
				auto_suggestions = false, -- Experimental stage
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = true, -- Enable clipboard support for better workflow
				minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
				enable_token_counting = false, -- Whether to enable token counting. Default to true.
			},
			hints = { enabled = true },
		},
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings
					default = {
						embed_image_as_base64 = false,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			-- Make sure to set this up properly if you have lazy=true
			{
				"MeanderingProgrammer/render-markdown.nvim",
				opts = { file_types = { "markdown", "Avante" } },
				ft = { "markdown", "Avante" },
			},
		},
		keys = {
			{ "<leader>a", "", desc = "Avante", mode = { "n", "v" } },
			{
				"<leader>aC",
				function()
					vim.cmd("AvanteClear")
				end,
				desc = "Clear Avante",
				mode = { "n", "v" },
			},
		},
	}
end

return {}
