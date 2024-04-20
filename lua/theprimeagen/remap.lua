vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.tabstop=1
vim.opt.relativenumber=true

vim.cmd("highlight Normal guibg=black")


-- optionally enable 24-bit colour
vim.opt.termguicolors = true


local key = vim.keymap.set
-- Explorer file
key("n", "<C-b>", ":NvimTreeToggle<CR>", {silent=true})
key("n", "<leader>ps", ":PackerSync<CR>", {silent=true})
-- comandi
key("v", "<leader>c", '"+y')


-- per salvare
vim.keymap.set("n", "<C-s>", vim.cmd.w)

