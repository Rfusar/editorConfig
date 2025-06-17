local M = {}

local nvim_home = vim.fn.stdpath("config")
local HOME_PATH = nvim_home.."/lua/core/plugin/email/"

function closeCache(msg) 
    vim.fn.jobstart({"7z", "a", HOME_PATH.."cache.7z", HOME_PATH.."cache/*"}, {
        on_exit=function()
            --vim.fn.delete(HOME_PATH.."cache/", "rf")
            require("notify")([[

    ]]..msg..[[

            ]])
        end
    })
end
function openCache(msg)
    local cmd = {"7z", "x", HOME_PATH.."cache.7z", "database.json", "-o"..HOME_PATH.."cache/"}
    vim.fn.jobstart(cmd, {on_exit=function() 
        require("notify")([[

    ]]..msg..[[

        ]])
    end})
end

function M.reload()
    local cmd = { "python3", HOME_PATH.."main.py", "--nvim-home", vim.fn.stdpath("config"), "--reload" }
    vim.fn.jobstart(cmd, {
--        on_exit=function() closeCache("Fetch completato") end
    })
end

function M.search()
    openCache("DB Disponibile") 
--    vim.ui.input({prompt="query: "}, function(input)  end)
end


return M

