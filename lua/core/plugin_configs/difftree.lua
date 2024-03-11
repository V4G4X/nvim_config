-- Initialize DiffTree, a git diff preview plugin

function DiffTree()
    local function diffOpenWithInput()
        local user_input = vim.fn.input("Revision to Open: ")
        vim.cmd("DiffviewOpen " .. user_input)
    end

    local function diffOpenFileHistory()
        local user_input = vim.fn.input("Files to Open: ")
        vim.cmd("DiffviewFileHistory" .. user_input)
    end

    -- Key maps
    require("which-key").register({
        g = {
            name = "Git", -- optional group name
            o = { diffOpenWithInput, "Open DiffView" },
            f = { diffOpenFileHistory, "Open DiffView on Files" },
        },
    }, { prefix = "<leader>" })
end

if not vim.g.vscode then DiffTree() end
