require("core.plugin.telescope")
require("core.plugin.tree")
require("core.plugin.color")
require("core.plugin.autocompletamento")
require("core.plugin.lettori")
require("core.plugin.startday")
require("core.plugin.comments")
local C = require("core.console.colors")

local log = require("notify")

log.setup({
  fps=11,
  background_colour = "#000000",
  timeout = 1000,
  render = "default",
  stages = "fade",
  top_down = false,
})




--GITHUB
function pushGithub(branch, namespace, comment)
    -- Validate commit message
    if comment == "" then
        log("Commit message cannot be empty!", "error")
        return
    end
    -- Escape quotes in commit message
    comment = comment:gsub('"', '\\"')
    
    -- Execute git commands with error handling
    local add_result = vim.fn.system('git add .')
    if vim.v.shell_error ~= 0 then
        log("Error adding files: "..add_result, "error")
        return
    end
    
    local commit_result = vim.fn.system({ "git", "commit", "-m", comment })
    if vim.v.shell_error ~= 0 then
        log("Error committing: "..commit_result, "error")
        return
    end
    
    local push_result = vim.fn.system({"git", "push", namespace, branch})
    if vim.v.shell_error ~= 0 then
        log("Error pushing: "..push_result, "error")
        return
    end
    
    log("Successfully pushed to "..namespace.."/"..branch, "info")
end

vim.api.nvim_create_user_command(
  "PushGithub",
  function(opts)
    local args = vim.split(opts.args, ", ")
    pushGithub(args[1], args[2], args[3])
  end,
  { nargs = 1 }
)
