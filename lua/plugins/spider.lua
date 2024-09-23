return {
    "chrisgrieser/nvim-spider",
    lazy = true,
    config = function()
        -- default values
        require("spider").setup {
            skipInsignificantPunctuation = false,
            subwordMovement = true,
            customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
        }
    end,
    keys = {
        {
            "w",
            "<cmd>lua require('spider').motion('w')<CR>",
            mode = { "n", "o", "x" },
        },
        {
            "e",
            "<cmd>lua require('spider').motion('e')<CR>",
            mode = { "n", "o", "x" },
        },
        {
            "b",
            "<cmd>lua require('spider').motion('b')<CR>",
            mode = { "n", "o", "x" },
        },
    }
}
