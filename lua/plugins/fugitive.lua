return {
    "tpope/vim-fugitive",
    dependencies = {
        "tpope/vim-rhubarb",
        "shumphrey/fugitive-gitlab.vim"
    },
    keys = {
        { "<leader>gB", "<cmd>GBrowse<CR>", desc = "Open in Browser" },
    },
    config = function()
        -- Custom Browse Function for Gitlab Integration
        vim.api.nvim_create_user_command(
            'Browse',
            function(opts) vim.fn.system { 'open', opts.fargs[1] } end,
            { nargs = 1 }
        )
    end,
}
