-- Initialize Fugitive, a git manager plugin (Prefer LazyGit over it though)

function Fugitive()
    -- Key maps
    require("which-key").register({
        g = {
            name = "Git", -- optional group name
            s = { vim.cmd.Git, "Fugitive" },
        },
    }, { prefix = "<leader>" })
end

if not vim.g.vscode then Fugitive() end
