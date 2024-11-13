return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require('spectre').setup()
        -- Key maps
        vim.keymap.set("n", "<leader>s", "", { desc = "Search" })
        vim.keymap.set("n", "<leader>ss", function() require('spectre').open() end, { desc = "Open Spectre" })
        vim.keymap.set("n", "<leader>sw", function() require('spectre').open_visual({ select_word = true }) end,
            { desc = "Search Current Word" })
        vim.keymap.set("n", "<leader>sf", function() require('spectre').open_file_search({ select_word = true }) end,
            { desc = "Search in Current File" })
        vim.keymap.set("v", "<leader>ss", function()
            vim.cmd('noau normal! "vy"')
            local text = vim.fn.getreg('v')
            require('spectre').open({ search_text = text })
        end, { desc = "Search selection" })
    end,
}
