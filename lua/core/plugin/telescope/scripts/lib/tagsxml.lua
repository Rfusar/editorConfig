function at(args, _table) table.insert(_table, args) end

local Handler = {
    ["memory"] = {},
    ["xml"] = {},
    ["prev"] = {
        ["tab"] = 0,
        ["tag"] = "",
        ["value"] = "",
    },
    ["current"] = {
        ["tab"] = 0,
        ["tag"] = "",
        ["value"] = "",
    },
}

function Handler:addToMemory(args) table.insert(Handler["memory"], args) end

function checkTags(
        f_lines_obj    -- {int, int}
    )  

    local temp_row = ""
    local VALUE_IS_NULL = Handler["current"]["value"] == nil
    local CREATE_CHILD  = Handler["current"]["tab"] > Handler["prev"]["tab"]
    local CLOSE_TAG = Handler["prev"]["tab"] > Handler["current"]["tab"]
    local ENDFILE_TAGS_NOT_CLOSED = f_lines_obj[1] == f_lines_obj[2]
    local DIFF_TABS = Handler["prev"]["tab"]-Handler["current"]["tab"]
    
    Handler["current"]["value"] = Handler["current"]["value"] or ""
    print("VALUE_IS_NULL:           "..tostring(VALUE_IS_NULL))
    print("CREATE_CHILD:            "..tostring(CREATE_CHILD))
    print("CLOSE_TAG:               "..tostring(CLOSE_TAG))
    print("ENDFILE_TAGS_NOT_CLOSED: "..tostring(ENDFILE_TAGS_NOT_CLOSED))
    print("DIFF_TABS:               "..DIFF_TABS)
    print("PREV_TAG:                "..Handler["prev"]["tag"])
    print("DETTAGLI RIGA:           "..Handler["current"]["tag"]..", "..Handler["current"]["value"])
    print("MANAGER:                 ["..vim.fn.join(Handler["memory"], ", ").."]")
    print("XML:                 "..vim.fn.join(Handler["xml"], "\n"))
    vim.fn.input("\n")
    

    --[DOC] Genero il template in base al valore del tag xml
    if VALUE_IS_NULL then temp_row = "<"..Handler["current"]["tag"]..">"
    else temp_row = "<"..Handler["current"]["tag"]..">"..Handler["current"]["value"].."</"..Handler["current"]["tag"]..">"
    end
    if ENDFILE_TAGS_NOT_CLOSED then 
        Handler:addToMemory(Handler["current"]["tag"]) 
        for i, key in ipairs(Handler["memory"]) do 
            at(string.rep("    ",Handler["prev"]["tab"]-i).."</"..key..">", Handler["xml"])
            table.remove(Handler["memory"], i) 
        end
    end

    temp_row = string.rep("    ", Handler["current"]["tab"]) .. temp_row

    if CREATE_CHILD then
        at(Handler["prev"]["tag"], Handler["memory"]) 
    end
    if CLOSE_TAG then
        for i = 1, math.abs(DIFF_TABS) do
            local n = #Handler["memory"]
            at(string.rep("    ", Handler["current"]["tab"] - i).."</"..Handler["memory"][n]..">", Handler["xml"])
            table.remove(Handler["memory"])
        end
    end

    at(temp_row, Handler["xml"])
    Handler["prev"]["tab"] = Handler["current"]["tab"]
    Handler["prev"]["tag"] = Handler["current"]["tag"]

end

function TagsXml()
  Handler["xml"] = {"\n"}
  local n_row = 0

  local f = io.open("KEYS.TXT", "r")
  local content = f:read("*a")
  local _, total_rows = content:gsub("\n", "\n")
  f:seek("set", 0)
  if not f then
    ErrorHandler("I can't find KEYS.TXT file")
    return
  end

  for line in f:lines() do
    n_row = n_row+1
    local leading = line:match("^(%s*)") or ""
    --[DOC] solo se la riga è valorizzata
    if line:match("(%w)") then
        Handler["current"]["tab"] = #leading / 4 or 0
        line = string.gsub(line, "    ", "")
        Handler["current"]["tag"], Handler["current"]["value"] = line:match("^(%S+)%s+(.+)$")
        --[DOC] in caso key == nil allora riassegna
        if Handler["current"]["value"]==nil then 
            Handler["current"]["tag"] = line:match("^(%S+)") 
        end
        checkTags({n_row, total_rows})
    end
  end
  f:close()
  for _, k in ipairs(Handler["xml"]) do print(k.."\n") end
  local result = vim.fn.join(Handler["xml"], "\n")
  vim.fn.setreg("+", result)
end

vim.api.nvim_create_user_command("TagsXml", function(opts)
        local args = vim.fn.split(opts.args, ", ")
        TagsXml()
    end,
{nargs = "*", complete = nil,})
