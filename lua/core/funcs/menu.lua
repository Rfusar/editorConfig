local previewers = require('telescope.previewers')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

local M = {} -- it serve for importing scripts

local home = vim.fn.stdpath('config') .. "/lua/core/funcs/scripts"

local funcs = {
    ["create tags  || create a file with the keys"] = home.."/tagsxml.txt",
    ["complete tag "] = home.."/method1xml.txt",
}

local func_names = {}
for name, _ in pairs(funcs) do
    table.insert(func_names, name)
end

function M.custom_picker()
  local reg = vim.fn.input("Choose regitry: ")
  if reg == "" then return end

  pickers.new({}, {
    prompt_title = "Choose Macro",
    border = false,
    finder = finders.new_table {
      results = func_names -- Content left display
   },

    previewer = previewers.new_buffer_previewer {
      define_preview = function(self, entry, status)
        local file_path = funcs[entry.value]
        if vim.fn.filereadable(file_path) == 1 then
          local file = io.open(file_path, "r")
          local content = file:read("*all")
          file:close()
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(content, "\n"))
        else
          vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {"File non disponibile o non leggibile"})
        end
      end
    },

    sorter = require('telescope.config').values.generic_sorter({}),

    attach_mappings = function(_, map)
      map('i', '<CR>', function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local file_path = funcs[selection.value]
        local content = io.open(file_path, "r"):read("*all")
        vim.fn.setreg(reg, content)
      end)
      return true
    end,
  }):find()
end
return M
