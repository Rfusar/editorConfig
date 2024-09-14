local S = require("core.config.snippets.const")
local G = require("core.config.snippets.gui")

local KEYS = S.getContentFileSnippets()

function addSnippetOnCurrentBuffer()
    for k, v in pairs(KEYS) do 
        print(" "..k.." "..v[1].." ") 
    end
    print("\n\n")
    local content = ""
    local res = vim.fn.input("Snippets: ")
    for k, v in pairs(KEYS) do 
        if res == k then 
            content = v[2] 
        end 
    end
    vim.fn.setreg("+", content)
end

function GUI() G.custom_picker() end

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('', '<leader>sni', ':lua addSnippetOnCurrentBuffer()<CR>', opts)
vim.api.nvim_set_keymap('', '<leader><leader>sni', ':lua GUI()<CR>', opts)
