function InitSpectre()
    require('spectre').setup()
    --
    -- Key maps
    local wk = require("which-key")
    wk.add({
        -- Search and replace mappings
        { "<leader>s",  group = "Search" },
        { "<leader>ss", function() require('spectre').open() end,                                   desc = "Open Spectre" },
        { "<leader>sw", function() require('spectre').open_visual({ select_word = true }) end,      desc = "Search Current Word" },
        { "<leader>sf", function() require('spectre').open_file_search({ select_word = true }) end, desc = "Search in Current File" },
    })
end

if not vim.g.vscode then InitSpectre() end
