
local colors = require("core.console.colors")
local key = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local macros = {
    ["q"] = {
        {'q', 'viwA"<Esc>viwb<Esc>i"<Esc>'},
        {'w', 's""<Esc>hp'}
    },
}

key('n', '<C-p>', ':lua SetMacros()<CR>', opts)
key('', '<leader><leader>c', ':lua SetCharComment()<CR>', opts)
key('', '<leader><leader>r', ':lua SetReplacement()<CR>', opts)
key('v', '<leader>tag', ':lua setTagHTML()<CR>', {})


function setTagHTML()
    local input = vim.fn.input("Tag HTML: ")
    local commands = 's<' .. input .. '></' .. input .. '><Esc>0f>p'
    local termcodes = vim.api.nvim_replace_termcodes(commands, true, false, true)
    vim.api.nvim_feedkeys(termcodes, 'n', true)
end

function SetCharComment()
    local input = vim.fn.input("Char Comment: ")
    local macro = 'I'..input..' <Esc>'
    local converted_macro = vim.api.nvim_replace_termcodes(macro, true, false, true)
    vim.fn.setreg('e', converted_macro)
end


function SetReplacement()
    local range = vim.fn.input("Row: ")
    local input = vim.fn.input("IN: ")
    local output = vim.fn.input("OUT: ")

    vim.cmd(':'..range..'s/'..input..'/'..output)
    print("\n\n")
    colors.SetColors('Replace from '..input..' to '..output, 'Success', '[OK]')
end


function SetDefaultMacros(key, testo)
    key = key or "q"
    testo = testo or "Macro impostata correttamente"
    for _, macro in ipairs(macros[key]) do
        local register = macro[1]
        local command = macro[2]
        local converted_macro = vim.api.nvim_replace_termcodes(command, true, false, true)
        vim.fn.setreg(register, converted_macro)
    end
    colors.SetColors(testo, 'Success', '[OK]')
end
SetDefaultMacros()

function SetMacros()
    print("q: @a -> racchiudi la parola tra doppie virgolette\n")
    print("q: @b -> racchiudi la frase tra doppie virgolette\n")
    local warning = "devi avere il testo gia selezionato prima di attivare la macro"
    colors.SetColors(warning, 'Warning', '[AVVISO]')
    local input = vim.fn.input("Inserisci un comando per il registro: ")
    print("\n\n")

    if macros[input] then
        local testo = "Set "..input.." impostato correttamente"
        SetDefaultMacros(input, testo)
    end
end

