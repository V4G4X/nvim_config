local function InitSwagger()
    require("swagger-preview").setup({
        -- The port to run the preview server on
        port = 8000,
        -- The host to run the preview server on
        host = "localhost",
    })
end


if not vim.g.vscode then InitSwagger() end
