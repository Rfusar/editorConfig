local G = require("core.snippets.gui")

function GUI() G.custom_picker() end

local key = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
key('', '<leader>sni', ':lua GUI()<CR>', opts)
