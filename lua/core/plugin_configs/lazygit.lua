-- Initialise LazyGit plugin

function InitLazyGit()
    -- Key maps
    require("which-key").register({
        g = {
            name = "Git", -- optional group name
            g = { "<cmd>LazyGit<cr>", "LazyGit", silent = true },
        },
    }, { prefix = "<leader>" })
end

if not vim.g.vscode then InitLazyGit() end
