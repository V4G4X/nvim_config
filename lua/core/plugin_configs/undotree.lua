-- Initalize UndoTree

function Undotree()
    -- Key maps
    require("which-key").add({
        { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undo Tree" },
    })
end

if not vim.g.vscode then Undotree() end
