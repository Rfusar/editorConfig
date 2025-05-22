local previewers = require('telescope.previewers')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values

local M = {}

local home = vim.fn.stdpath('config') .. "/lua/core/plugin/telescope/scripts/lib"

local funcs = {
    ["create tags  || create a file with the keys"] = home.."/tagsxml.lua",
    ["complete tag "] = home.."/method_xml_1.lua",
    ["push on your repository github"] = home.."/pushgithub.lua",
}

local func_names = vim.tbl_keys(funcs)

function M.custom_picker()
    local reg = vim.fn.input("Choose register [default: \"]: ")
    reg = reg ~= "" and reg or '"'  -- Default to unnamed register

    pickers.new({}, {
        prompt_title = "Choose Macro",
        finder = finders.new_table({
            results = func_names,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry,
                    ordinal = entry,
                }
            end
        }),

        previewer = previewers.new_buffer_previewer({
            title = "File Preview",
            define_preview = function(self, entry)
                local file_path = funcs[entry.value]
                if vim.fn.filereadable(file_path) ~= 1 then
                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {"[ERROR] File not readable: "..file_path})
                    return
                end

                local file, err = io.open(file_path, "r")
                if not file then
                    vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {"[ERROR] "..tostring(err)})
                    return
                end

                local content = file:read("*a")
                file:close()
                
                -- Add syntax highlighting
                vim.api.nvim_buf_set_option(self.state.bufnr, 'filetype', 'lua')
                vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, vim.split(content, "\n"))
            end
        }),

        sorter = conf.generic_sorter({}),

        attach_mappings = function(prompt_bufnr, map)
            map('i', '<CR>', function()
                local selection = action_state.get_selected_entry()
                if not selection then return end
                
                actions.close(prompt_bufnr)
                local file_path = funcs[selection.value]
                
                -- Safe file reading
                local file, err = io.open(file_path, "r")
                if not file then
                    vim.notify("Failed to open file: "..tostring(err), vim.log.levels.ERROR)
                    return
                end
                
                local content = file:read("*a")
                file:close()
                
                if selection.value:match("create tags") then
                    vim.fn.setreg(reg, content)
                    vim.notify("Content copied to register: "..reg, vim.log.levels.INFO)
                else
                    local chunk, err = loadstring(content)
                    if not chunk then
                        vim.notify("Failed to load Lua: "..tostring(err), vim.log.levels.ERROR)
                        return
                    end
                    
                    local success, err = pcall(chunk)
                    if not success then
                        vim.notify("Execution error: "..tostring(err), vim.log.levels.ERROR)
                    end
                end
            end)
            
            return true
        end,
    }):find()
end

return M
