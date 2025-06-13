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
        vim.system({"python", "lua/core/temp_dev/main.py"})
    end,
    {nargs = 0}
)

vim.api.nvim_create_user_command(
    "Domanda",
    function(opts) AI.start() end,
    {nargs = 0}
)
