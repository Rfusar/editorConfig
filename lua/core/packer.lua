vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
     requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'nvim-tree/nvim-web-devicons'

  use ('nvim-tree/nvim-tree.lua', {run = ':TSUpdate'})
  use ('nvim-treesitter/nvim-treesitter',{run = ':TSUpdate'})
  
  use { "catppuccin/nvim", as = "catppuccin" }


  -- Lettore File CSV
  use 'akinsho/toggleterm.nvim'
  use 'theKnightsOfRohan/csvlens.nvim'
  --Lettore File MD
    use({ "iamcco/markdown-preview.nvim", 
        run = "cd app && npm install", 
        setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, 
    })


 -- Plugin per LSP (Language Server Protocol)
  use 'neovim/nvim-lspconfig'    

  -- Plugin per nvim-cmp e le sue fonti
  use 'hrsh7th/nvim-cmp'         -- Il motore di completamento principale
  use 'hrsh7th/cmp-nvim-lsp'     -- Fonte di completamento per LSP
  use 'hrsh7th/cmp-buffer'       -- Fonte di completamento per il buffer
  use 'hrsh7th/cmp-path'         -- Fonte di completamento per i percorsi
  use 'hrsh7th/cmp-cmdline'      -- Fonte di completamento per la cmdline

  -- Per utenti vsnip
  use 'hrsh7th/cmp-vsnip'        -- Integrazione con vsnip
  use 'hrsh7th/vim-vsnip'        -- Motore di snippet

end)
