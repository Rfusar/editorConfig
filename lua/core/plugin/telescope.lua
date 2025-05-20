
local builtin = require('telescope.builtin')

local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local themes = require('telescope.themes')

-- require('nvim-treesitter.configs').setup({
--   highlight = { enable = true },
--   ensure_installed = { "python", }, 
-- })

--  require('telescope.builtin').buffers()
function getGit()
  pickers.new(themes.get_dropdown({}), {
    prompt_title = "Menu Project",
    finder = finders.new_table({
      results = {
          "Commits", "Branches", "Status",
      },
    }),
    sorter = conf.generic_sorter({
      sorting_strategy = "ascending", -- oppure "descending"
    }),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        
        if selection then
          local key = selection.value
          if key then
                vim.notify(key)
                if key == "Commits" then builtin.git_commits()
                elseif key == "Branches" then builtin.git_branches()
                elseif key == "Status" then builtin.git_status()
                end
          end
        end
      end)
      return true
    end,
  }):find()
end

function getSearch()
    local res = vim.fn.input("[files, search] Scelta: ")

    if res == "files" then builtin.find_files()
    elseif res == "search" then builtin.live_grep()
    end
end



vim.keymap.set('n', '<leader>g', getGit, {})
vim.keymap.set('n', '<leader>f', getSearch, {})

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
