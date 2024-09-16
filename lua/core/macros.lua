
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
key('n', '<leader>tag', ':lua setTagHTML()<CR>', {})




function setTagHTML()
    local isReact = vim.fn.input("is React [y/n]: ")
    isReact = (isReact == "y")

    local tag = vim.fn.input("Tag HTML: ")
    local id = vim.fn.input("Id: ")
    local class = vim.fn.input("Class: ")
    local tabs = tonumber(vim.fn.input("Tabs: ")) or 1


    local stringa = '<' .. tag

    if id ~= "" then stringa = stringa .. ' id="' .. id .. '"' end

    if class ~= "" then
        local c = ""
        if isReact then c = ' className="'
        else c = ' class="' end
        stringa = stringa .. c .. class .. '"'
    end

    if stringa:sub(-1) ~= '>' then stringa = stringa .. '>' end

    stringa = stringa .. '</' .. tag .. '>'
    vim.api.nvim_put({stringa}, 'c', true, true)

    -- Posiziona il cursore all'interno del TagHtml
    local text = "hbhhi<CR><CR><Esc>ki"
    -- add Tabs
    for t=1, tabs do text = text .. "<Tab>" end

    local termcodes = vim.api.nvim_replace_termcodes(text, true, false, true)
    vim.api.nvim_feedkeys(termcodes, 'n', true)
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
    --colors.SetColors(testo, 'Success', '[OK]')
end
SetDefaultMacros()

function SetMacros()
    print("q: @q -> racchiudi la parola tra doppie virgolette\n")
    print("q: @w -> racchiudi la frase tra doppie virgolette\n")
    local warning = "devi avere il testo gia selezionato prima di attivare la macro"
    colors.SetColors(warning, 'Warning', '[AVVISO]')
    local input = vim.fn.input("Inserisci un comando per il registro: ")
    print("\n\n")

    if macros[input] then
        local testo = "Set "..input.." impostato correttamente"
        SetDefaultMacros(input, testo)
    end
end

