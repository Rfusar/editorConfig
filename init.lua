require("core.packer")
require("core.remap")
require("core.help")
require("core.ricordi")
require("core.plugin")
require("core.debugger")
require("core.checkDipendenze")
local AI = require("core.plugin.API_AI")


vim.api.nvim_create_user_command(
    "Films",
    function(opts) 
        vim.fn.jobstart("start cmd", 
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
