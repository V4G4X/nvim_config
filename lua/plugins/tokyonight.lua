if not vim.g.vscode then
    return {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            ---@class tokyonight.Config
            require("tokyonight").setup({
                style = "night", -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
                transparent = true, -- Enable this to disable setting the background color
                styles = {
                    -- Style to be applied to different syntax groups
                    -- Background styles. Can be "dark", "transparent" or "normal"
                    sidebars = "transparent", -- style for sidebars, see below
                    floats = "transparent", -- style for floating windows
                },
                dim_inactive = true,
            })
        end
    }
end

return {}
