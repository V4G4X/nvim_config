-- Initialise LazyGit plugin

function InitLazyGit()
    -- Key maps
    require("which-key").add({
        { "<leader>g",  group = "Git" },
        { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    })
end

if not vim.g.vscode then InitLazyGit() end
