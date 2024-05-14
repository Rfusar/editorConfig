vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'Weyaaron/nvim-training'

  use 'nvim-lua/plenary.nvim' 
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-tree/nvim-web-devicons'
  use ('nvim-tree/nvim-tree.lua', {run = ':TSUpdate'})
  use { "catppuccin/nvim", as = "catppuccin" }


end)
