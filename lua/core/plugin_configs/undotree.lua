-- Initalize UndoTree

function Undotree()
    -- Key maps
    require("which-key").register({
        u = { vim.cmd.UndotreeToggle, "Undo Tree" },
    }, { prefix = "<leader>" })
end

if not vim.g.vscode then Undotree() end
