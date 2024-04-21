vim.opt.readonly = false

vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.tabstop=1



vim.cmd("highlight Normal guibg=black")


-- optionally enable 24-bit colour
vim.opt.termguicolors = true


local key = vim.keymap.set
-- Explorer file
key("n", "<C-b>", ":NvimTreeToggle<CR>", {silent=true})
key('', "<leader>so", vim.cmd.so)
key("n", "<leader>ps", ":PackerSync<CR>", {silent=true})

key("", "<leader>123", function() 
								vim.opt.number = true
								vim.opt.relativenumber = false
end, {silent=true})

key("", "<leader>101",  function() 
									vim.opt.relativenumber = true
							  vim.opt.number = false 
end, {silent=true})


-- comandi
key("v", "<leader>c", '"+y')


-- per configurare ovunque si è 
key("", "<leader>cfg", function()  vim.cmd(":!x-terminal-emulator -e 'nvim ~/.config/nvim'")end)
key("", "<leader>help", function() vim.cmd(":!x-terminal-emulator -e 'nvim ~/.config/nvim/documentazione.txt'")end)



-- per salvare
vim.keymap.set("n", "<C-s>", vim.cmd.w)

