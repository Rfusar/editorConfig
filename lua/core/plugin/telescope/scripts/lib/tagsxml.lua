
-- HOW TO USE
--
-- the file config must call KEYS.TXT, the uppercase is mandatory
-- you can use :pwd for position of the KEYS.TXT
--

local f = io.open("KEYS.TXT", "r")
if not f then
  print("I can't find KEYS.TXT")
  return
end

local results = {}
for line in f:lines() do
  local key, value = line:match("^(%S+)%s+(.+)$")
  local onlykey = line:match("^(%S+)")
  if key and value then
    table.insert(results, "<" .. key .. ">" .. value .. "</" .. key .. ">")
  elseif onlykey then
    table.insert(results, "<" .. onlykey .. "></" .. onlykey .. ">")
  end
end
f:close()

vim.api.nvim_put(results, "l", true, true)

--  vim.api.nvim_put(lines, type, after, follow)
--  lines (table):
--        Un array di stringhe (righe di testo) che vuoi inserire.
--  
--  type (string):
--        Specifica come il testo viene inserito:
--  
--          "l" (line-wise): Inserisce le righe come nuove linee (come p in modalità linea).
--          "c" (char-wise): Inserisce il testo inline (come p in modalità normale).
--  
--  after (boolean):
--        Se true, inserisce il testo dopo il cursore (come p).
--  
--  follow (boolean):
--        Se true, sposta il cursore dopo il testo inserito.
