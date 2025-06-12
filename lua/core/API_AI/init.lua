local PROVIDERS = {
    ["deepseek"] = {
        ["url"] = "https://router.huggingface.co/novita/v3/openai/chat/completions",
        ["model"] = "deepseek/deepseek-v3-0324",
        ["action"] = "chat",
    },
}

local action = {}
vim.ui.input({prompt="Chiedi a Agent AI [chat,]: "}, function(input)
    if input == "chat" then 
        action = PROVIDERS["deepseek"]
    end
end)

if action == {} then return end


local body = ""
vim.ui.input({prompt="Cosa ti serve? "}, function(input) 

end)

    local body = [[
{
    "messages": [
        {
            "role": "user",
            "content": "]]..input..[["
        }
    ],
    "model": "]]..action["model"]..[[",
    "stream": false
}
]]
    body = vim.fn.split(body, "\n")
    vim.fn.writefile(body, "lua/core/API_AI/body.json", "")




vim.cmd("!python lua/core/API_AI/test.py")
vim.cmd(":vsplit lua/core/API_AI/result_python.txt")


--local n = require("notify")
--local IS_EXPENSE = false
--local IS_CONTENT = false
--local expense = {}
--local content = {}
--
--
--for l in file:lines() do 
--    if l == "EXPENSE" then IS_EXPENSE = true  end
--    if l == "CONTENT" then 
--        IS_EXPENSE=false
--        IS_CONTENT = true 
--    end
--
--    if IS_EXPENSE and l~="EXPENSE" then table.insert(expense, l) end
--    if IS_CONTENT and l~="CONTENT" then table.insert(content, l) end
--
--end
--
--function createContent(title, _table)
--    local temp_str = ""
--    for _,l in ipairs(_table) do 
--        temp_str=temp_str..l.."\n"
--    end
--    return temp_str
--end
--
--local str_expense = createContent("EXPENSE", expense)
--local str_content = createContent("CONTENT", content)

--n.notify("\n\n"..str_expense.."\n\n", "error", {title="EXPENSE", timeout=5000})
--n.notify("\n\n"..str_content.."\n\n", "info", {title="RESPONSE", timeout=false})
