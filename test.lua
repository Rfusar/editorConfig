local tipo

function setMove(value, type)
  local keys = vim.api.nvim_replace_termcodes(value, true, true, true)
  vim.api.nvim_feedkeys(keys, type, false)
end



for row, content in ipairs(vim.fn.readfile("script.txt")) do
  if row == 1 then
    tipo = content
  end

  local count = 0
  for _ in content:gmatch("    ") do
    count = count + 1
  end


  if count == 0 then
    print("zero livello")
  elseif count == 1 then
    print("primo livello")
  elseif count == 2 then
    print("secondo livello")
  end
end
