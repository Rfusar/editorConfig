local M = {}
local home = vim.fn.getcwd() .. "/lua/core/config/snippets/libs"

local snippets = {
    ["gw1"] = {home .. "/go_Server1.txt", "|| GO   || Server Init Golang"},
    ["gw2"] = {home .. "/go_Server2.txt", "|| GO   || Server Utils Golang"},
    ["html"] = {home.."/html.txt", "|| HTML || Default Page"},
    ["pe"] = {home.."/py_Imap.txt", "|| PY   || Connect Imap"},
}

-- Funzione per ottenere il contenuto dei file di snippet
function M.getContentFileSnippets()
    local Snippets = {}  -- Dichiarato localmente all'interno della funzione
    for cmd, s in pairs(snippets) do
        local file_path, description = s[1], s[2]
        local file = io.open(file_path, "r")
        
        if file then
            local content = file:read("*all")
            file:close()
            Snippets[cmd] = {description, content}
        else
            print("Impossibile aprire il file: " .. file_path)
        end
    end
    return Snippets
end

return M
