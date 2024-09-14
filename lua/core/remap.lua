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
local opts = { noremap = true, silent = true }
-- Explorer file
key("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
key("", "<leader>so", ":source %<CR>", opts)
key("n", "<leader>ps", ":PackerSync<CR>", opts)
key("n", "<leader>pu", ":PackerUpdate<CR>", opts)

--Lettori
--Csv
key('', "<leader>csv", ":Csvlens<CR>", opts)
--MD
key('', "<leader>mds", ":MarkdownPreview<CR>", opts)
key('', "<leader>mdq", ":MarkdownPreviewStop<CR>", opts)
    
-- grandezzza pagina
key("n", "<M-,>", "<c-w>5<")
key("n", "<M-.>", "<c-w>5>")
key("n", "<M-u>", "<C-W>+")
key("n", "<M-d>", "<C-W>-")

--Set num a lato
key("", "<leader>123", function() vim.opt.number = true; vim.opt.relativenumber = false end, opts)
key("", "<leader>101", function() vim.opt.relativenumber = true; vim.opt.number = false end, opts)


--gestion buffers di copia
vim.opt.shortmess:append("c")
vim.api.nvim_create_augroup("autoreload", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    group = "autoreload",
    command = "checktime"
})
key("v", "<leader>c", '"+y')


-- configurazione remota 
key("", "<leader>cfg", function()  vim.cmd(":!x-terminal-emulator -e 'nvim ~/.config/nvim'")end, opts)
key("", "<leader>help", function() vim.cmd(":!x-terminal-emulator -e 'nvim ~/.config/nvim/README.md'")end, opts)


-- Salvataggi
key("", "<C-s>", ":w<CR>", ops)
key("", "<leader>sa", ":wa<CR>", opts)
