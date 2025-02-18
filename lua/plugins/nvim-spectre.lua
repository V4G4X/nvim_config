if not vim.g.vscode then
    return {
        "nvim-pack/nvim-spectre",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local spectre = require('spectre')
            spectre.setup()
            local utils = require("utils")
            -- Key maps
            vim.keymap.set("n", "<leader>s", "", { desc = "Search" })
            vim.keymap.set("n", "<leader>ss", spectre.open, { desc = "Open Spectre" })
            vim.keymap.set("n", "<leader>sw", function() spectre.open_visual({ select_word = true }) end,
                { desc = "Search Current Word" })
            vim.keymap.set("n", "<leader>sf", function() spectre.open_file_search({ select_word = true }) end,
                { desc = "Search in Current File" })
            vim.keymap.set("v", "<leader>ss", function() spectre.open({ search_text = utils.get_visual_selection() }) end,
                { desc = "Search selection" })
        end,
    }
end

return {}
