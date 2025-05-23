require("notify").setup({
    background_colour = "#000000",
    timeout = 1000,
    render = "default", -- compact - simple - minimal - default
    stages = "fade",    -- fade_in_slide_out - fade - slide - static
})  

local timer = vim.loop.new_timer()

local sleep = 1 * 1000 * 60 -- 1min
timer:start(0, 60000, vim.schedule_wrap(function()
    local time = os.date("*t")  -- tabella con ora, min, sec, ecc.

    if time.hour == 12 and time.min == 00 then require("notify")("Segna il foglio ore su ODOO", "info")
    elseif time.hour == 12 and time.min == 30 then require("notify")("Segna il foglio ore su ODOO", "info")
    elseif time.hour == 17 and time.min == 30 then require("notify")("Segna il foglio ore su ODOO", "info")
    elseif time.hour == 18 and time.min == 00 then require("notify")("Segna il foglio ore su ODOO", "info")
    elseif time.hour == 23 and time.min == 00 then require("notify")("Sono le 23, colgione", "info")
    end
end))

