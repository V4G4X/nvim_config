-- Initialize Fugitive, a git manager plugin (Prefer LazyGit over it though)

function Fugitive()
    -- Custom Browse Function for Gitlab Integration
    vim.api.nvim_create_user_command(
        'Browse',
        function(opts) vim.fn.system { 'open', opts.fargs[1] } end,
        { nargs = 1 }
    )

    -- Key maps
    require("which-key").register({
        g = {
            name = "Git", -- optional group name
            s = { vim.cmd.Git, "Fugitive" },
            b = { '<cmd>GBrowse<CR>', "Open in Browser" },
        },
    }, { prefix = "<leader>" })
end

if not vim.g.vscode then Fugitive() end
