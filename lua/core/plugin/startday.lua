local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

function cmd_startDay(url)
    local cmd
    if vim.fn.has("mac") == 1 then cmd = { "open", url }
    elseif vim.fn.has("unix") == 1 then cmd = { "xdg-open", url }
    elseif vim.fn.has("win32") == 1 then cmd = { "cmd", "/c", "start", "", url }
    end
    if cmd then vim.fn.jobstart(cmd, { detach = true })
    end
end

local name_links = {}
local links = {
    ["aruba"] = "https://webmail.aruba.it/",
    ["vm_zoho"] = "https://assist.zoho.eu/org/20105218809/app/home",
    ["zoho"] = "https://desk.zoho.eu/agent/nemesissolutionsag/nemesis-solutions-ag/tickets/list/open-cases?view=classic",
    ["drive"] = "https://drive.google.com/drive/home",
    ["odoo"] = "https://erp.nemesisag.com/web#action=120&active_id=mail.box_inbox&cids=1&menu_id=82",
}
for k, _ in pairs(links) do table.insert(name_links, k) end

function StartDay()
    pickers.new(require("telescope.themes").get_dropdown({}), {
      prompt_title = "Start Day - Open Fast",
      finder = finders.new_table { results = name_links },
      sorter = conf.generic_sorter({}),
    
      attach_mappings = function(prompt_bufnr, map)
        -- toggle selection con <Tab>
        map("i", "<Tab>", function()
          actions.toggle_selection(prompt_bufnr)
          actions.move_selection_next(prompt_bufnr)
        end)
    
        -- conferma con invio e stampa selezione
        map("i", "<CR>", function()
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local selections = current_picker:get_multi_selection()
          for _, entry in ipairs(selections) do
            cmd_startDay(links[entry.value])
          end
          actions.close(prompt_bufnr)
        end)
        return true
      end,
    }):find()
end

vim.keymap.set("", "<F2>", ":lua StartDay()<CR>", {})
