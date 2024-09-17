local C = require('core.console.colors')
local key = vim.keymap.set

function DelCharComment()
    local stringa = vim.api.nvim_replace_termcodes('I<Del><Esc>', true, false, true)
    vim.fn.setreg('d', stringa)
    C.SetColors('DelCharComment Success', 'Success', '[OK]')
end
DelCharComment()

function SetCharComment()
    local input = vim.fn.input("Char Comment: ")
    local macro = 'I'..input..' <Esc>'
    local converted_macro = vim.api.nvim_replace_termcodes(macro, true, false, true)
    vim.fn.setreg('v', converted_macro)
    C.SetColors('SetCharComment Success', 'Success', '[OK]')
end


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

local opts = {noremap=true, silent=true}
key('n', '<leader>crs', ':lua CleanSearch()<CR>', opts)
key('n', '<leader>cr', ':lua CleanRegistries()<CR>', opts)
