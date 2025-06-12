local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local builtin = require("telescope.builtin")
local pickers = require('telescope.pickers')
local finders = require("telescope.finders")
local previewers = require("telescope.previewers")
local conf = require("telescope.config").values


local home = "C:/Users/Utente/Desktop/RDP"
local vm = {
    ["Local_KCM"] = home.."/KCM/KCM.lnk",
    ["Local_KTA"] = home.."/KTA/KTA.lnk",
    ["Lactalis"] = home.."/Lactalis.lnk"
}
local titles = {}
for k, _ in pairs(vm) do table.insert(titles, k) end

function vm_ui()
  pickers.new(require("telescope.themes").get_dropdown({}), {
    prompt_title = "Virtual Machine",
    finder = finders.new_table {
      results = titles,
   },
    previewer = custom_previewer,
    sorter = require('telescope.config').values.generic_sorter({}),
    attach_mappings = function(_, map)
      -- When select a snippets save on + registry
      map('i', '<CR>', function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        local path = vm[selection.value]
        vim.cmd(":! start "..path)
      end)
      return true
    end,
  }):find()
end

if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.keymap.set("", "<F12>", ":lua vm_ui()<CR>", {})
end
