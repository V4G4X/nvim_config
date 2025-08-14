local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

-- Load plugin configurations
require("plugins")
-- Load core configurations
require("core")

if not vim.g.vscode then
	vim.cmd.colorscheme("tokyonight")
end
vim.cmd("hi LineNr guifg=#AAAAAA") -- Set Line Number coloring to be lighter than the theme default
