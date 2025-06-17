local function set_python_path(path)
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'pyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client.notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

return {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  single_file_support = true,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",  -- "off", "basic", "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {
          reportUnusedVariable = "warning",  -- o "error"
          reportUnusedImport = "warning",
          reportMissingImports = "error",
          reportUndefinedVariable = "error",
        },
      },
      docstringFormat = "numpy",  -- o "google", "restructuredtext"
      inlayHints = {
        variableTypes = true,
        functionReturnTypes = true,
      },
    },
  },
  on_attach = function(client, bufnr)
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Mostra diagnostica" })
      
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = "Vai alla definizione" })
      
      vim.keymap.set('n', 'K', function()
          local params = vim.lsp.util.make_position_params()
          local hover_results, hover_ctx = client.request_sync('textDocument/hover', params, 1000, bufnr)
          local sig_results = client.request_sync('textDocument/signatureHelp', params, 1000, bufnr)
          local lines = {}

          if hover_results and hover_results.result and hover_results.result.contents then
              local hover_lines = vim.lsp.util.convert_input_to_markdown_lines(hover_results.result.contents)
              vim.list_extend(lines, hover_lines)
          end
          
          if #lines > 0 then
              vim.lsp.util.open_floating_preview(lines, "markdown", {
                  title="Documentazione",
                  title_pos="right",
                  relative="editor",
                  border = "rounded",
                  focusable = false,
                  max_width = 90,
                  max_height = 40,
              })
          end
      end, { buffer = bufnr, desc = "Documentazione estesa" })
  end
}
