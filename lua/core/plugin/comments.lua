vim.api.nvim_set_hl(0, "CommentRed",   { fg = "#FF5555", bg="#000000", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentBlue",  { fg = "#52CBFF", bg="#000000", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentGreen", { fg = "#55FF55", bg="#000000", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentTODO",  { fg = "#EAB810", bg="#000000", bold = true, italic = true })
vim.api.nvim_set_hl(0, "CommentViolet",{ fg = "#EE33FF", bg="#000000", bold = true, italic = true })

local ns = vim.api.nvim_create_namespace("custom_comments")

local hash = { danger = "#!.*", question = "^#%?.*", todo = "#TODO.*", comment = "#%[DOC%].*", violet="#%..*"}
local slash = { danger = "//!.*",question = "^//%?.*", todo = "//TODO.*", comment = "//%[DOC%].*", violet="//%..*" }
local apos = { danger = "'!.*", question = "'%?.*", todo = "'TODO.*", comment = "'%[DOC%].*", violet="'%..*" }
local minus = { danger = "%-%-!.*", question = "%-%-%?.*", todo = "%-%-TODO.*", comment = "%-%-%[DOC%].*", violet="%-%-%..*" }

--!    test comment
--?    test comment
--.    test comment
--[DOC]    test comment
--TODO test comment


local patterns = {
  lua = minus,
  python = hash,
  powershell = hash,
  javascript = slash,
  c = slash,
  vb = apos,
  cs = slash,
  cpp = slash,
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
    elseif line:match(pat.violet) then
      vim.api.nvim_buf_add_highlight(bufnr, ns, "CommentViolet", i - 1, 0, len)
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
