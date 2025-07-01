local function Reload(filename, filtered)
    
        local file = io.open(filename, "w")
        if file then
          for _, line in ipairs(filtered) do
            file:write(line .. "\n")
          end
          file:close()
        end

end


function ClearCode() 
    local filename = vim.api.nvim_buf_get_name(0)
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    
    local filtered = {}
    for _, line in ipairs(lines) do
      if not line:match("Non serve in produzione") then
        table.insert(filtered, line)
      end
    end
    
    Reload(filename, filtered) 

    vim.cmd("edit!")
end


function PromptAI()
  local filename = vim.api.nvim_buf_get_name(0)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local keywords = {}
  local filtered = {}
  local in_vars = false

  for _, line in ipairs(lines) do
      print(line)
    if line:match("^VARIABILI") then
        in_vars = true
        table.insert(filtered, "VARIABILI")
    elseif line:match("^PROMPT") then
        in_vars = false
        table.insert(filtered, "")

    elseif in_vars then
        local key, val = line:match("^(%w+)=(.*)$")
        if key and val then
            table.insert(filtered, line)
            keywords[key] = val
        end
    else
        table.insert(filtered, line)
        -- Sostituzione delle variabili nel prompt
        local substituted = line:gsub("%%(.-)%%", function(var)
            return keywords[var] or ("%" .. var .. "%")
        end)
        table.insert(filtered, substituted)
    end
  end

  Reload(filename, filtered) 
end
