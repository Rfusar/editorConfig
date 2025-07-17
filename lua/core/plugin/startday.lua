local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

-- Apri URL nel browser
local function open_url(url)
    local cmd
    if vim.fn.has("mac") == 1 then
        cmd = { "open", url }
    elseif vim.fn.has("unix") == 1 then
        cmd = { "xdg-open", url }
    elseif vim.fn.has("win32") == 1 then
        if string.match(url, "^https?://") then
            cmd = { "cmd", "/c", "start", "", url }
        else cmd = {url}
        end
    end
    if cmd then
        vim.fn.jobstart(cmd, {detach=true})
    end
end


-- Mappa nomi a link/eseguibili
local name_links = {}
local links = {
    ["email"] = "C:/Program Files/Mozilla Thunderbird/thunderbird.exe",
    ["vm_zoho"] = "https://assist.zoho.eu/org/20105218809/app/home",
    ["zoho"] = "https://desk.zoho.eu/agent/nemesissolutionsag/nemesis-solutions-ag/tickets/list/open-cases?view=classic",
    ["drive"] = "https://drive.google.com/drive/home",
    ["odoo"] = "https://erp.nemesisag.com/web#action=120&active_id=mail.box_inbox&cids=1&menu_id=82",
    ["ticket - kofax"] = "https://partner.kofax.com/s/",
}
for k in pairs(links) do
    table.insert(name_links, k)
end

-- Telescope picker
function StartDay()
    pickers.new(require("telescope.themes").get_dropdown({}), {
        prompt_title = "Start Day - Open Fast",
        finder = finders.new_table { results = name_links },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            map("i", "<Tab>", function()
                actions.toggle_selection(prompt_bufnr)
                actions.move_selection_next(prompt_bufnr)
            end)

            map("i", "<CR>", function()
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                local selections = current_picker:get_multi_selection()
                for _, entry in ipairs(selections) do
                    open_url(links[entry.value])
                end
                actions.close(prompt_bufnr)
            end)

            return true
        end,
    }):find()
end

-- Mappatura tasto
vim.keymap.set("", "<F2>", ":lua StartDay()<CR>", {})
