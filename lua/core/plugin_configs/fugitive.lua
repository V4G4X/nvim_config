-- Initialize Fugitive, a git manager plugin (Prefer LazyGit over it though)

function Fugitive()
    -- Custom Browse Function for Gitlab Integration
    vim.api.nvim_create_user_command(
        'Browse',
        function(opts) vim.fn.system { 'open', opts.fargs[1] } end,
        { nargs = 1 }
    )

    -- Key maps
    require("which-key").add({
        { "<leader>g",  group = "Git" },
        { "<leader>gb", "<cmd>GBrowse<CR>", desc = "Open in Browser" },
        { "<leader>gs", vim.cmd.Git,        desc = "Fugitive" },
    })
end

if not vim.g.vscode then Fugitive() end
