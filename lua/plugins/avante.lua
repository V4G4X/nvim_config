if not vim.g.vscode then
	return {
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
		opts = {
			---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | "bedrock" | string
			provider = "or_devstral",
			mode = "agentic",
			providers = {
				or_devstral = {
					__inherited_from = "openai",
					api_key_name = "OPENROUTER_API_KEY",
					endpoint = "https://openrouter.ai/api/v1/",
					model = "mistralai/devstral-medium",
				},
				grok_fast = {
					__inherited_from = "openai",
					endpoint = "https://api.x.ai/v1/",
					api_key_name = "XAI_API_KEY",
					model = "grok-4-fast-reasoning",
				},
				gpt5 = {
					__inherited_from = "openai",
					model = "gpt-5",
					extra_request_body = {
						temperature = 1,
						reasoning_effort = "low",
					},
				},
				gpt_5_codex = {
					__inherited_from = "openai",
					model = "gpt-5-codex",
				},
				gpt_41 = {
					__inherited_from = "openai",
					model = "gpt-4.1",
				},
				o4_mini = {
					__inherited_from = "openai",
					model = "o4-mini",
				},
				o3 = {
					__inherited_from = "openai",
					model = "o3",
					extra_request_body = {
						reasoning_effort = "high",
					},
				},
				or_gemini = {
					__inherited_from = "openai",
					api_key_name = "OPENROUTER_API_KEY",
					endpoint = "https://openrouter.ai/api/v1/",
					model = "google/gemini-2.5-pro",
				},
				perp_quick = {
					__inherited_from = "openai",
					api_key_name = "PERPLEXITY_API_KEY",
					endpoint = "https://api.perplexity.ai",
					model = "sonar-pro",
				},
				perp_think = {
					__inherited_from = "openai",
					api_key_name = "PERPLEXITY_API_KEY",
					endpoint = "https://api.perplexity.ai",
					model = "sonar-reasoning-pro",
				},
				perp_r1 = {
					__inherited_from = "openai",
					api_key_name = "PERPLEXITY_API_KEY",
					endpoint = "https://api.perplexity.ai",
					model = "r1-1776",
				},
			},
			behaviour = {
				auto_suggestions = false, -- Experimental stage
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = false,
				support_paste_from_clipboard = true, -- Enable clipboard support for better workflow
				minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
				enable_token_counting = false, -- Whether to enable token counting. Default to true.
				auto_approve_tool_permissions = false,
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
			{
				"<leader>aC",
				function()
					vim.cmd("AvanteClear")
				end,
				desc = "Clear Avante",
				mode = { "n", "v" },
			},
			{
				"<leader>as",
				function()
					vim.cmd("AvanteSwitchProvider bedrock")
				end,
				desc = "Switch to Bedrock",
				mode = { "n", "v" },
			},
			{
				"<leader>aA",
				(function()
					local is_agentic = true
					return function()
						is_agentic = not is_agentic
						local new_mode = is_agentic and "agentic" or "legacy"
						require("avante.config").override({ mode = new_mode })
						vim.notify("Avante mode: " .. new_mode, vim.log.levels.INFO)
					end
				end)(),
				desc = "Toggle Agentic Mode",
				mode = { "n", "v" },
			},
		},
	}
end

return {}
