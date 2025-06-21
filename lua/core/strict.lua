-- namespace condiviso
local ns = vim.api.nvim_create_namespace("help_for_good_code")

-- funzione di highlighting
local function highlight(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  for i, line in ipairs(lines) do
    local start_pos, end_pos = line:find("%s+$")
    if start_pos then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "ExtraSpace", i - 1, start_pos - 1, end_pos)
    end
  end
end

-- autocmd group per poterlo rimuovere
local group = vim.api.nvim_create_augroup("StrictHighlight", { clear = true })

vim.api.nvim_create_user_command("StrictEnable", function()
  vim.api.nvim_set_hl(0, "ExtraSpace", { bg = "#FF5555" })

  vim.api.nvim_create_autocmd({ "BufReadPost", }, {
    group = group,
    callback = function(args)
      highlight(args.buf)
    end,
  })

  require("notify")("Strict highlight abilitato", "info", {timeout=500})
end, {})

vim.api.nvim_create_user_command("StrictDisable", function()
  vim.api.nvim_clear_autocmds({ group = group })
  vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
  require("notify")("Strict highlight disabilitato", "info", {timeout=500})
end, {})
