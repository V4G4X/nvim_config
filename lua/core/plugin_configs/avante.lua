function ConfigureAvante()
    require("avante").setup()

    require("which-key").add({
        { "<leader>a", group = "Avante", mode = { "n", "v" } },
    })
end

if not vim.g.vscode then ConfigureAvante() end
