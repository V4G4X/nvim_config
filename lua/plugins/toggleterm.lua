return {
  "akinsho/toggleterm.nvim",
  version = "*",
    opts = {
      open_mapping = '<c-t>',
      direction = "float",
    },
  config = function(_, opts)
    require("toggleterm").setup(opts)
  end,
}
