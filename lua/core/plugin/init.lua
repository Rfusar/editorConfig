require("core.plugin.telescope")
require("core.plugin.tree")
require("core.plugin.color")
require("core.plugin.autocompletamento")
require("core.plugin.lettori")
require("core.plugin.startday")
require("core.plugin.comments")
local C = require("core.console.colors")
local L = require("core.plugin.notify")

--GITHUB
function pushGithub(branch, namespace, comment)
    -- Validate commit message
    if comment == "" then
        L.log("Commit message cannot be empty!", "error", {timeout=10000})
        return
    end
    -- Escape quotes in commit message
    comment = comment:gsub('"', '\\"')
    
    -- Execute git commands with error handling
    local add_result = vim.fn.system('git add .')
    if vim.v.shell_error ~= 0 then
        L.log("Error adding files: "..add_result, "error", {timeout=10000})
        return
    end
    
    local commit_result = vim.fn.system({ "git", "commit", "-m", comment })
    if vim.v.shell_error ~= 0 then
        L.log("Error committing: "..commit_result, "error", {timeout=10000})
        return
    end
    
    local push_result = vim.fn.system({"git", "push", namespace, branch})
    if vim.v.shell_error ~= 0 then
        L.log("Error pushing: "..push_result, "error", {timeout=10000})
        return
    end
    
    L.log("Successfully pushed to "..namespace.."/"..branch, "info", {timeout=500})
end

vim.api.nvim_create_user_command(
  "PushGithub",
  function(opts)
    local args = vim.split(opts.args, ", ")
    pushGithub(args[1], args[2], args[3])
  end,
  { nargs = 1 }
)
