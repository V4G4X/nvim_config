-- Initalize Ollama

function Ollama()
    -- Key maps
    require("which-key").register({
        o = { name = "Ollama", ["1"] = "which_key_ignore" }, -- special label to hide it in the popup
    }, { prefix = "<leader>", mode = { "n", "v" } })
end

if not vim.g.vscode then Ollama() end
