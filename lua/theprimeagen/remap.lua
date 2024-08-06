vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
         
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.autoread = true

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


vim.opt.shortmess:append("c")
vim.api.nvim_create_augroup("autoreload", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    group = "autoreload",
    command = "checktime"
})

-- comandi
key("v", "<leader>c", '"+y')


-- per configurare ovunque si è 
key("", "<leader>cfg", function()  vim.cmd(":!x-terminal-emulator -e 'nvim ~/.config/nvim'")end)
key("", "<leader>help", function() vim.cmd(":!x-terminal-emulator -e 'nvim ~/.config/nvim/documentazione.txt'")end)



-- per salvare
key("", "<C-s>", vim.cmd.w)
key("", "<leader>sa", ":wa<CR>")
