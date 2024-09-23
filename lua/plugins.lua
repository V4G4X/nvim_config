-- Function to get all Lua files in the plugins directory
local function get_plugin_configs()
  local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
  local plugin_files = vim.fn.glob(plugin_dir .. "/*.lua", false, true)
  local plugins = {}

  for _, file in ipairs(plugin_files) do
    local module_name = vim.fn.fnamemodify(file, ":t:r")
    table.insert(plugins, require("plugins." .. module_name))
  end

  return plugins
end

-- Setup lazy.nvim with dynamically loaded plugin configs
require("lazy").setup(get_plugin_configs())
