require("notify").setup({
    background_colour = "NotifyBackground",
    timeout = 1000,
    render = "default", -- compact - simple - minimal - default
    stages = "fade",    -- fade_in_slide_out - fade - slide - static
})  
require("notify")("My Message")
