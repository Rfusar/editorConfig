local dap = require('dap')
local dapui = require('dapui')

dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    local port = (config.connect or config).port
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = 'C:/Users/Utente/AppData/Local/Programs/Python/Python310/python.exe',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      return 'C:/Users/Utente/AppData/Local/Programs/Python/Python310/python.exe'
    end;
  },
}

dapui.setup()

dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end

local opts = {noremap=true, silent=true}
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
vim.keymap.set('n', '<F5>', function() dap.continue() end, opts)
vim.keymap.set('n', '<F10>', function() dap.step_over() end, opts)
vim.keymap.set('n', '<F11>', function() dap.step_into() end, opts)
vim.keymap.set('n', '<F12>', function() dap.step_out() end, opts)
vim.keymap.set('n', '<leader>du', function() require('dapui').toggle() end, opts)

