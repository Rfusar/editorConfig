local notify = require("notify")

local M = {}

M.myLog = function(msg)
    notify(msg, {
        title = "Notifica",
        timeout = 1000,
        background_colour = "#000000",
        render = "default",
        stages = "fade",
    })
end

local timer = vim.loop.new_timer()

local sleep = 1 * 1000 * 60 -- 1min
timer:start(0, 60000, vim.schedule_wrap(function()
    local time = os.date("*t")  -- tabella con ora, min, sec, ecc.

    if time.hour == 12 and time.min == 00 then M.myLog("Segna il foglio ore su ODOO", "info")
    elseif time.hour == 12 and time.min == 30 then M.myLog("Segna il foglio ore su ODOO", "info")
    elseif time.hour == 17 and time.min == 30 then M.myLog("Segna il foglio ore su ODOO", "info")
    elseif time.hour == 18 and time.min == 00 then M.myLog("Segna il foglio ore su ODOO", "info")
    elseif time.hour == 23 and time.min == 00 then M.myLog("Sono le 23, colgione", "info")
    end
end))

return M
