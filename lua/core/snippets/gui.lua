local previewers = require('telescope.previewers')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {}
-- Ottieni il percorso di lavoro corrente
local home = vim.fn.stdpath('config') .. "/lua/core/snippets/libs"

-- Definisci i percorsi relativi rispetto al percorso attuale
local snippets = {
   ["Default Page - HTML"] = home .. "/html.html",
   ["Server Init - Golang"] = home .. "/go_Server1.go",
   ["Server Utils -  Golang"] = home .. "/go_Server2.go",
   ["Connect Imap - Python"] = home .. "/py_Imap.py",
   ["Base - CSS"] = home .. "/web/css/style.css",
   ["Utils - JS"] = home .. "/web/js/utils.js",
}

local snippet_names = {}
for name, _ in pairs(snippets) do
    table.insert(snippet_names, name)
end

local custom_previewer = previewers.new_buffer_previewer {
  define_preview = function(self, entry, status)
    local file_path = snippets[entry.value]
    if vim.fn.filereadable(file_path) == 1 then
      local file = io.open(file_path, "r")
      local content = file:read("*all")
      file:close()
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(content, "\n"))
    else
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {"File non disponibile o non leggibile"})
    end
  end
}

function M.custom_picker()
  pickers.new({}, {
    prompt_title = "Scegli Snippets",
    finder = finders.new_table {
      results = snippet_names -- Content left display
   },
    previewer = custom_previewer,
    sorter = require('telescope.config').values.generic_sorter({}),
    attach_mappings = function(_, map)
      -- When select a snippets save on + registry
      map('i', '<CR>', function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local file_path = snippets[selection.value]
        local file = io.open(file_path, "r")
        if file then
            local content = file:read("*all")
            file:close()
            vim.fn.setreg('+', content)  -- Copia il contenuto negli appunti
        end
      end)
      return true
    end,
  }):find()
end

return M
