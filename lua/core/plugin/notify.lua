local notify = require("notify")

notify.setup({
  background_colour = "#000000",
  timeout = 1000,
  render = "default",
  stages = "fade",
})

local M = {}

M.myLog = function(msg, level)
  notify(msg, level or "info", { title = "Git Push" })
end


local timer = vim.loop.new_timer()

local sleep = 1 * 1000 * 60 -- 1min
timer:start(0, sleep, vim.schedule_wrap(function()
    local time = os.date("*t")  -- tabella con ora, min, sec, ecc.

    if time.hour == 12 and time.min == 00 then M.myLog("Segna il foglio ore su ODOO")
    elseif time.hour == 12 and time.min == 30 then M.myLog("Segna il foglio ore su ODOO")
    elseif time.hour == 17 and time.min == 30 then M.myLog("Segna il foglio ore su ODOO")
    elseif time.hour == 18 and time.min == 00 then M.myLog("Segna il foglio ore su ODOO")
    end
end))

return M
