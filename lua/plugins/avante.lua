return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    version = false,
    dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
        { 'MeanderingProgrammer/render-markdown.nvim', opts = { file_types = { "markdown", "Avante" }, }, ft = { "markdown", "Avante" }, },
    },
    keys = {
        { "<leader>a", "", desc = "Avante", mode = { "n", "v" } },
    },
    config = function()
        require("avante").setup()
    end
}
