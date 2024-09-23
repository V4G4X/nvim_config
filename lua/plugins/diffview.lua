-- Diff View for Git Revisions
return {
  "sindrets/diffview.nvim",
  config = function()
    local function diffOpenWithInput()
      local user_input = vim.fn.input("Revision to Open: ")
      vim.cmd("DiffviewOpen " .. user_input)
    end

    local function diffOpenFileHistory()
      local user_input = vim.fn.input("Files to Open: ")
      vim.cmd("DiffviewFileHistory" .. user_input)
    end

    -- Key maps
    require("which-key").add({
      { "<leader>g",  group = "Git" },
      { "<leader>gf", diffOpenFileHistory, desc = "Open DiffView on Files" },
      { "<leader>go", diffOpenWithInput,   desc = "Open DiffView" },
    })
  end,
}
