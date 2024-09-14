vim.opt.termguicolors = true

require'nvim-tree'.setup {
  filters = {
    custom = {'.gitignore'},
    exclude = {'.gitignore'}  
  },
  view = {
    width = 30,
    side = 'left',
    auto_resize = false,
  },
  git = {
    enable = true,
    ignore = false  -- Imposta questo a false per non ignorare i file ignorati da git
  },
}

require('nvim-web-devicons').setup()
