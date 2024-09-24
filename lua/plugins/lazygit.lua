return {
  "kdheepak/lazygit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>g",  desc = "Git" },
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
}