return {
    "LintaoAmons/easy-commands.nvim",
    event = "VeryLazy",
    config = function()
        require("easy-commands").setup()
    end,
}
