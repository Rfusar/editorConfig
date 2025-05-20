local G = require("core.funcs.menu")

--local opt = { noremap = true, silent = true }
local opt = {}

vim.keymap.set('', '<leader>qs', function()
  G.custom_picker()
end, opt)

vim.keymap.set("n", "<leader>qe", function()
  local reg = vim.fn.input("Registry: ")
  local str = vim.fn.getreg(reg)

  local fn, err = loadstring(str)
  if not fn then
    print("Errore nel parsing del codice: " .. err, vim.log.levels.ERROR)
    return
  end
  fn()

end, opt)
