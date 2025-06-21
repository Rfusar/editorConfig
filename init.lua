require("core.packer")
require("core.remap")
require("core.help")
require("core.ricordi")
require("core.plugin")
require("core.debugger")
require("core.lsp_server")
require("core.strict")
require("core.dependecies")



--[DOC] Tools with Python
local AI = require("core.plugin.API_AI")
local EMAIL = require("core.plugin.email")

vim.api.nvim_create_user_command(
    "Films",
    function(opts) 
        local terminal = ""
        local OS = vim.loop.os_uname().sysname
        if OS == "Windows_NT" then terminal = "cmd"
        elseif OS == "Linux" then   terminal = "x-terminal-emulator"
        end
        vim.fn.jobstart(terminal, 
            { 
                detach = true, 
                cwd=vim.fn.stdpath("config").."/lua/core/plugin/film" 
            })
    end,
    {nargs = 0}
)

vim.api.nvim_create_user_command(
    "Domanda",
    function(opts) AI.start() end,
    {nargs = 0}
)

--vim.api.nvim_create_user_command(
--    "Email",
--    function(opts) 
--        if opts.args == "--reload" then EMAIL.reload()
--        elseif opts.args == "--search" then EMAIL.search()
--        end
--
--    end,
--    {nargs = 1}
--)
