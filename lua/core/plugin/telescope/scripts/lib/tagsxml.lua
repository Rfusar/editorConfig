-- HOW TO USE
--
-- on the registry a you got a macro for doing this:
--
-- FROM
--  <cmd/>
--  
-- TO
--  <cmd>value</cmd>
--
-- execute the function with :lua setValue()

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function setValue(value, reg)
    vim.fn.setreg(reg, t("A<Esc>vh<Del>vbyA>"..value.."</<Esc>pa>"))
end


function to_readable_keys(str)
  return str
    :gsub("\27", "<Esc>")     -- ESC (^[ o \x1b)
    :gsub("\13", "<CR>")      -- ^M
    :gsub("\9", "<Tab>")      -- ^I
    :gsub("([\128-\255])", function(c)
      return string.format("<%02X>", c:byte())
    end)
end

-- print(to_readable_keys(vim.fn.getreg("q")))


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

vim.api.nvim_create_user_command("TagsXml", function(opts)
    local args = vim.fn.split(opts.args, ", ")
    if #args > 0 then 
        setValue(args[1], args[2])
    else TagsXml()
    end
end, 
{nargs = "*", complete = nil,})
