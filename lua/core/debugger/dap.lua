local M = {}
local dap = require('dap')
local C = require('core.console.colors')
local log = require("core.plugin.notify")

local function get_python_path()
    local is_windows = vim.fn.has('win32') == 1
    local venv_path

    if is_windows then
        venv_path = vim.fn.getcwd() .. '/venv/Scripts/python.exe'
        if vim.fn.executable(venv_path) == 1 then
            log.log("Sono su windows ed'è presente il venv", "info", {})
            return venv_path
        end
    else
        venv_path = vim.fn.getcwd() .. '/venv/bin/python3'
        if vim.fn.executable(venv_path) == 1 then
            log.log("Sono su Unix-like ed'è presente il venv", "info", {})
            return venv_path
        end
    end
    log.log("m'attacco al python di sistema per il debug", "info", {} )
    return is_windows and 'C:/Users/Utente/AppData/Local/Programs/Python/Python310/python.exe' or '/usr/bin/python3'
end

function M.InitDap()
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
          command = get_python_path(),  -- Usa la funzione per ottenere il percorso
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
          return get_python_path()  -- Usa la funzione per ottenere il percorso
        end;
      },
    }
    
    local opts = {noremap=true, silent=true}
    vim.keymap.set('n', '<leader>dt', function() require('dap').terminate() end, opts) 
    vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
    vim.keymap.set('n', '<F5>', function() dap.continue() end, opts)
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, opts)
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, opts)
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, opts)
end

return M
