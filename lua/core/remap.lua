vim.g.mapleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
if vim.loop.os_uname().sysname == "Windows_NT" then vim.opt.clipboard = 'unnamedplus' end
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'              

-- Tab
vim.opt.tabstop = 4          
vim.opt.softtabstop = 4             
vim.opt.shiftwidth = 4             
vim.opt.expandtab = true    

-- UI config
vim.opt.number = true      
vim.opt.relativenumber = true     
vim.opt.cursorline = true    
vim.opt.splitbelow = true    
vim.opt.splitright = true   

local key = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Packer and run script lua
key("n", "<leader>so", ":source %<CR>", opts)
key("n", "<leader><leader>ps", ":PackerSync<CR>", opts)
key("n", "<leader>pu", ":PackerUpdate<CR>", opts)

key('n', '<leader>fh', ":lua require('telescope.builtin').help_tags()<CR>", {})
-- Save file and files
key("", "<C-s>", ":w!<CR>", ops)
key("", "<leader>sa", ":wa!<CR>", opts)

--Registries
function CleanRegistries()
    local registers = { 
        '"', '0', '1', '2', '3', '4', '5', 
        '6', '7', '8', '9', 'a', 'b', 'c', 
        'f', 'g', 'h', 'i', 'j', 
        'k', 'l', 'm', 'n', 'o', 'p', 
        's', 'u', 'v', 'x', 
        'y', 'z', '*', '+'
    }
    for _, reg in ipairs(registers) do
        vim.fn.setreg(reg, '')
    end
    C.SetColors('Clean Registries', 'Success', '[OK]')
end
function CleanSearch() vim.fn.setreg("/", '') end
key('n', '<leader>crs', ':lua CleanSearch()<CR>', opts)
key('n', '<leader>cr', ':lua CleanRegistries()<CR>', opts)


-- Explorer file
key("n", "<C-b>", ":NvimTreeToggle<CR>", opts)

-- Set width and height of the current window
key("n", "<M-,>", "<c-w>5<")
key("n", "<M-.>", "<c-w>5>")
key("n", "<M-u>", "<C-W>-")
key("n", "<M-d>", "<C-W>+")
key('n', '<C-a>', 'ggVG', opts)

--Set num on rows
key("", "<leader>123", function() vim.opt.number = true; vim.opt.relativenumber = false end, opts)
key("", "<leader>101", function() vim.opt.relativenumber = true; vim.opt.number = false end, opts)

-- Clipboard management 
vim.opt.shortmess:append("c")
vim.api.nvim_create_augroup("autoreload", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    group = "autoreload",
    command = "checktime"
})
key("v", "<leader>c", '"+y')


-- Remote Configuration 
local OS = vim.loop.os_uname().sysname
if OS == "Windows_NT" then
    key("", "<leader>cfg", function() vim.cmd(":!cmd.exe /c start nvim C:/Users/Utente/AppData/Local/nvim") end, opts)

elseif OS == "Linux" then
    key("", "<leader>cfg", function()  vim.cmd(":!x-terminal-emulator -e 'nvim ~/.config/nvim'")end, opts)

end

-- Help
function Help()
    local file_path = vim.fn.stdpath('config').."/README.md"
    local file = io.open(file_path, "r")
    if file then
        file:close()
        vim.cmd('leftabove vsplit ' .. file_path)
        vim.cmd('vertical resize 70')
    else
        print("Errore: Impossibile aprire il file " .. file_path)
    end
end

key('n', '<leader>help', ':lua Help()<CR>', opts)
