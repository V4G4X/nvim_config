vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 25
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Enable line and column display in the status line
vim.opt.ruler = true

-- Enable mouse support
vim.opt.mouse = 'a'

-- Enable highlighting of the current line
vim.opt.cursorline = true

-- Ignore case when searching
vim.opt.ignorecase = true

-- Override the 'ignorecase' option if the search pattern contains upper case characters
vim.opt.smartcase = true

vim.o.exrc = true

-- Keymaps for moving lines/selections up and down
vim.keymap.set("n", "<C-k>", ":m .-2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", ":m .+1<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv", { noremap = true, silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv", { noremap = true, silent = true })

-- Quickfix navigation mappings
vim.keymap.set("n", "]q", ":cnext<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "[q", ":cprev<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>q", function()
    local qf_exists = false
    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_exists = true
        end
    end
    if qf_exists == true then
        vim.cmd "cclose"
    else
        vim.cmd "copen"
    end
end, { noremap = true, silent = true, desc = "Toggle quickfix list" })
