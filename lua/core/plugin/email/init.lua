local M = {}

local nvim_home = vim.fn.stdpath("config")
local HOME_PATH = nvim_home.."/lua/core/plugin/email/"

function M.start()
    vim.ui.input({prompt="args: "}, function (input)
        if not input then return end
        local args = vim.fn.split(input, " ")
        local cmd = { "python3", HOME_PATH.."main.py", "--nvim-home", vim.fn.stdpath("config"), unpack(args) }
        vim.fn.jobstart(cmd, {on_exit=function() 
            vim.system({"7z", "a", HOME_PATH.."cache", HOME_PATH.."cache"})
            vim.fn.delete(HOME_PATH.."cache/", "rf")
        end})
    end)
end

return M
