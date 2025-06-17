local path = vim.fn.stdpath("config")
local input_file = path .. "/lua/core/plugin/translator/_input.txt"

local function get_python_cmd()
  return (vim.loop.os_uname().sysname == "Windows_NT") and "python" or "python3"
end

vim.api.nvim_create_user_command("InputTraduzione", function()
  vim.cmd(":vsplit " .. input_file)
end, {})

vim.api.nvim_create_user_command("GeneraTraduzione", function()
  vim.fn.jobstart({
    get_python_cmd(),
    path .. "/lua/core/plugin/translator/test.py",
    "-nh", path .. "/lua/core/plugin/translator",
    "-lin", "it_IT",
    "-lout", "en_US",
  }, {
    on_exit = function()
      vim.cmd(":vsplit " .. path .. "/lua/core/plugin/translator/_input.txt")
    end,
  })
end, {})

