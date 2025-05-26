function TagsXml()
    local f = io.open("KEYS.TXT", "r")
    if not f then
      require("notify").notify("I can't find KEYS.TXT file", "error")
      return
    end
    
    local results = {}
    for line in f:lines() do
      local key, value = line:match("^(%S+)%s+(.+)$")
      local onlykey = line:match("^(%S+)")
      if key and value then
        table.insert(results, "<" .. key .. ">" .. value .. "</" .. key .. ">")
      elseif onlykey then
        table.insert(results, "<" .. onlykey .. "></" .. onlykey .. ">")
      end
    end
    f:close()
    
    local result = vim.fn.join(results, "\n")
    vim.fn.setreg("+", result)
end

vim.api.nvim_create_user_command("TagsXml", TagsXml, {nargs = 0})
