-- Startup Page
return {
    "startup-nvim/startup.nvim",
    opts = {
        theme = "startify",
    },
    config = function(_, opts)
        require "startup".setup(opts)
    end
}
