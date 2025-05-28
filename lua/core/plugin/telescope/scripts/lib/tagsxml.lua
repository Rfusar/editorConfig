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
function ErrorHandler(err) 
    require("notify").notify([[
]]..err..[[

    ]], "error", {timeout=5000})
end
function at(args, _table) table.insert(_table, args) end

--TODO sviluppare gestioni errori [guarda i FIXES sul :h tagsxml]

function checkTags(
    current_ct_obj,-- {tab, tag}
    prev_ct_obj,   -- {tab, tag}
    manager,       -- array [keys of open tags]
    row,           -- table
    xml_data,      -- {key, value}
    f_lines_obj    -- {int, int}
    )  
    --print("current_tab: "..current_ct_obj["tab"])
    --print("current_tag: "..current_ct_obj["tag"])
    --print("prev_tab: "..prev_ct_obj["tab"])
    --print("prev_tag: "..prev_ct_obj["tag"])
    --print("current_tab: "..vim.fn.join(xml_data, ", "))
    --print("manager: "..vim.fn.join(manager, ", "))
    --vim.fn.input("\n")
    local temp_row = ""
    -- [DOC] Genero il template in base al valore del tag xml
    if #xml_data == 1 then temp_row = "<"..xml_data[1]..">"
    else temp_row = "<"..xml_data[1]..">"..xml_data[2].."</"..xml_data[1]..">"
    end
    temp_row = string.rep("    ", current_ct_obj["tab"]) .. temp_row
    --[DOC] se current_tab > saved_tab then close tag xml
    --TODO decidere nome per variabile boolean per gestire la condizione
    if current_ct_obj["tab"] == 0 and prev_ct_obj["tab"] == 0 and prev_ct_obj["tag"] == current_ct_obj["tag"] then 
        temp_row = temp_row.."</"..xml_data[1]..">"

    elseif current_ct_obj["tab"] > prev_ct_obj["tab"] then 
        at(prev_ct_obj["tag"], manager)

    elseif current_ct_obj["tab"] < prev_ct_obj["tab"] then 
        at(string.rep("    ", current_ct_obj["tab"]-1).."</"..manager[#manager]..">", row)
        table.remove(manager, 1) 
    end
    at(temp_row, row)
    prev_ct_obj["tab"] = current_ct_obj["tab"]
    prev_ct_obj["tag"] = current_ct_obj["tag"]
    if f_lines_obj[1] == f_lines_obj[2] then 
        print(vim.fn.join(manager, ", "))
        for i, key in ipairs(manager) do 
            at(string.rep("    ",current_ct_obj["tab"]-i).."</"..key..">", row)
            table.remove(manager, i) 
        end
    end

end

function TagsXml()
  local f = io.open("KEYS.TXT", "r")
  local content = f:read("*a")
  local _, total_rows = content:gsub("\n", "\n")
  f:seek("set", 0)
  if not f then
    ErrorHandler("I can't find KEYS.TXT file")
    return
  end

  local results = {}
  local manager = {}
  local current_tag = { tab = -1, tag = ""}
  local prev_tag = { tab = -1, tag = ""}
  local n_row = 0
  for line in f:lines() do
    n_row = n_row+1
    local leading = line:match("^(%s*)") or ""
    --[DOC] solo se la riga è valorizzata
    if line:match("(%w)") then
        current_tag["tab"] = #leading / 4 or 0
        line = string.gsub(line, "    ", "")
        local key, value = line:match("^(%S+)%s+(.+)$")
        --[DOC] in caso key == nil allora riassegna
        if value==nil then 
            key = line:match("^(%S+)") 
        end
        current_tag["tag"] = key
        checkTags(current_tag, prev_tag, manager, results, {key, value}, {n_row, total_rows})
    end
  end
  f:close()
  local result = vim.fn.join(results, "\n")
  vim.fn.setreg("+", result)
end

vim.api.nvim_create_user_command("TagsXml", function(opts)
        local args = vim.fn.split(opts.args, ", ")
        TagsXml()
    end,
{nargs = "*", complete = nil,})
