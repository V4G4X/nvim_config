if not vim.g.vscode then
    return {
        "yetone/avante.nvim",
        event = "VeryLazy",
        lazy = false,
        version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
        opts = {
            ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
            provider = "openrouter", -- Recommend using Claude
            vendors = {
                openrouter = {
                    __inherited_from = "openai",
                    api_key_name = "OPENROUTER_API_KEY",
                    endpoint = "https://openrouter.ai/api/v1/",
                    -- model = "openai/o3-mini-high",
                    model = "anthropic/claude-3.5-sonnet",
                },
            },
        },
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            "echasnovski/mini.pick",         -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua",              -- for file_selector provider fzf
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
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
            { 'MeanderingProgrammer/render-markdown.nvim', opts = { file_types = { "markdown", "Avante" }, }, ft = { "markdown", "Avante" }, },
        },
        keys = {
            { "<leader>a",  "",                                    desc = "Avante",       mode = { "n", "v" } },
            { "<leader>aC", function() vim.cmd("AvanteClear") end, desc = "Clear Avante", mode = { "n", "v" } },
        },
    }
end

return {}
