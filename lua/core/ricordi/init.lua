local function open_file_in_split(file_path)
    -- Controlla se il file esiste
    local file = io.open(file_path, "r")
    if file then
        file:close()

        -- Crea una nuova finestra (split) sopra la finestra corrente e carica il file
        vim.cmd('aboveleft split ' .. file_path)  -- Apri il file in split sopra
        vim.cmd('resize 10')
    else
        print("Errore: Impossibile aprire il file " .. file_path)
    end
end

local filepath = vim.fn.stdpath('config') .. "/lua/core/ricordi/ricordi.txt"
local key = vim.api.nvim_set_keymap

function Ricordi()
    open_file_in_split(filepath)
    print("diocane"..filepath)
end

key('n', '<leader><leader>t', ':lua Ricordi()<CR>', { noremap = true, silent = true })
