-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- For `luasnip` users.
    end,
  },
  mapping = {
    ['<Down>'] = cmp.mapping.select_next_item(), -- Seleziona il suggerimento successivo
    ['<Up>'] = cmp.mapping.select_prev_item(), 
    ['<M-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<M-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<M-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
})

-- Array di server LSP e relative configurazioni
local lsp_servers = {
  pyright = {},
  ts_ls = {},
  --clangd = {},
  --gopls = {},
}

-- Configura ogni server LSP
for server, config in pairs(lsp_servers) do
  require('lspconfig')[server].setup(vim.tbl_extend('force', {
    capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
  }, config))
end
