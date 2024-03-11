-- nvim-spider. Move by subwords and skip insignificant punctuation.

local function InitSpider()
    -- default values
    require("spider").setup {
        skipInsignificantPunctuation = true,
        subwordMovement = true,
        customPatterns = {}, -- check "Custom Movement Patterns" in the README for details
    }

    vim.keymap.set(
        { "n", "o", "x" },
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        { desc = "Spider-w" }
    )
    vim.keymap.set(
        { "n", "o", "x" },
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        { desc = "Spider-e" }
    )
    vim.keymap.set(
        { "n", "o", "x" },
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        { desc = "Spider-b" }
    )
end


InitSpider()