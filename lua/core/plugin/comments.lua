vim.api.nvim_set_hl(0, "CommentRed",   { fg = "#FF5555", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentBlue",  { fg = "#06E2CF", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentGreen", { fg = "#55FF55", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentTODO",  { fg = "#EAB810", bold = true, italic = true })

local ns = vim.api.nvim_create_namespace("custom_comments")

local patterns = {
  lua = {
    danger = "^%-%-!.*",
    question = "^%-%-%?.*",
    todo = "^%-%-%s*TODO.*",
    comment = "^%-%-.*",
  },
  python = {
    danger = "^#!.*",
    question = "^#%?.*",
    todo = "^#%s*TODO.*",
    comment = "^#.*",
  },
  powershell = {
    danger = "^#!.*",
    question = "^#%?.*",
    todo = "^#%s*TODO.*",
    comment = "^#.*",
  },
  javascript = {
    danger = "^//!.*",
    question = "^//%?.*",
    todo = "^//%s*TODO.*",
    comment = "^//.*",
  },
  c = {
    danger = "^//!.*",
    question = "^//%?.*",
    todo = "^//%s*TODO.*",
    comment = "^//.*",
  },
}

local function highlight(bufnr, filetype)
  if not patterns[filetype] or not vim.api.nvim_buf_is_valid(bufnr) then return end
  
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local pat = patterns[filetype]

  for i, line in ipairs(lines) do
    local len = #line
    if line:match(pat.danger) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentRed", i - 1, 0, len)
    elseif line:match(pat.question) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentBlue", i - 1, 0, len)
    elseif line:match(pat.todo) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentTODO", i - 1, 0, len)
    elseif line:match(pat.comment) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentGreen", i - 1, 0, len)
    end
  end
end

vim.api.nvim_create_autocmd({
  "BufEnter", 
  "BufWritePost", 
  "TextChanged", 
  "TextChangedI", 
  "FileType"
}, {
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if patterns[ft] then
      highlight(args.buf, ft)
    end
  end,
})
