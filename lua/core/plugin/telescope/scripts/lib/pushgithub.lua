-- HOW TO USE
--
-- registry a func that you can able to push on repository 

function pushGithub(branch, namespace, comment)
    -- Validate commit message
    if comment == "" then
        print("Commit message cannot be empty!")
        return
    end
    -- Escape quotes in commit message
    comment = comment:gsub('"', '\\"')
    
    -- Execute git commands with error handling
    local add_result = vim.fn.system('git add .')
    if vim.v.shell_error ~= 0 then
        print("Error adding files: "..add_result)
        return
    end
    
    local commit_result = vim.fn.system('git commit -m "'..comment..'"')
    if vim.v.shell_error ~= 0 then
        print("Error committing: "..commit_result)
        return
    end
    
    local push_result = vim.fn.system('git push '..namespace..' '..branch)
    if vim.v.shell_error ~= 0 then
        print("Error pushing: "..push_result)
        return
    end
    
    print("Successfully pushed to "..namespace.."/"..branch)
end
