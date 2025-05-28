local function open_file_in_split(file_path)
    local file = io.open(file_path, "r")
    if file then
        file:close()
        vim.cmd('aboveleft split ' .. file_path)  -- Apri il file in split sopra
        vim.cmd('resize 20')
    else
        print("Errore: Impossibile aprire il file " .. file_path)
    end
end

local filepath_ricordi = vim.fn.stdpath('config') .. "/lua/core/ricordi/ricordi.md"
local filepath_appunti = vim.fn.stdpath('config') .. "/lua/core/ricordi/notes.txt"

function Ricordi() open_file_in_split(filepath_ricordi) end
function Appunti() open_file_in_split(filepath_appunti) end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<leader><leader>t', ':lua Ricordi()<CR>', opts)
vim.keymap.set('n', '<leader><leader>a', ':lua Appunti()<CR>', opts)
