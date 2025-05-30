local notify = require("notify")

notify.setup({
  fps=11,
  background_colour = "#000000",
  render = "default",
  stages = "fade",
  top_down = true,
})

local M = {}

M.log = function(msg, type, opts)
    if opts == "work" then 
        notify(msg, type, {
            on_close = function()
                local key = vim.api.nvim_replace_termcodes("<F2>", true, true, true)
                vim.fn.feedkeys(key, "")
            end
        })

    else notify([[


    ]]..msg..[[


]], type, opts)
    end
end

--local timer = vim.loop.new_timer()
--
--local sleep = 10 * 60 * 1000
--local reminder = false
--
--timer:start(0, sleep, vim.schedule_wrap(function()
--  local time = os.date("*t")
--  -- reset reminder all'inizio di ogni ora per evitare blocchi a tempo indefinito
--  if time.min == 0 then
--    reminder = false
--  end
--
--  if not reminder and (time.hour == 8 or time.hour == 9) then
--    M.log([[
--Buongiorno,
--
--    Che si fa Oggi??
--]], 
--"info", "work")
--    reminder = true
--    elseif not reminder and (time.hour == 12 or time.hour == 13) then
--    M.log([[
--Segna il foglio ore su ODOO
--]],
--"info", "work")
--    reminder = true
--
--  elseif not reminder and (time.hour == 17 or time.hour == 18) then
--    M.log([[
--Segna il foglio ore su ODOO
--]],
--"info", "work")
--    reminder = true
--  else
--    reminder = false
--  end
--end))
--
return M
