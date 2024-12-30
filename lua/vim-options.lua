vim.opt.termguicolors = true
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.opt.expandtab = true
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.g.mapleader = " "
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.listchars = { trail = "⇲", tab = "◦ " }
vim.opt.list = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.mouse = "a"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<C-l>", ":wincmd l<CR>")
vim.keymap.set("n", "<leader>bn", ":bnext<CR>")
vim.keymap.set("n", "<leader>bp", ":bprev<CR>")
vim.keymap.set("n", "<leader>bcc", ":bdelete<CR>")
vim.keymap.set("n", "<leader>sf", ":write<CR>", { desc = "Save file" })

