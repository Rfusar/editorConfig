-- Setup nvim-cmp
local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            -- Configura il tuo snippet manager qui
            vim.fn["vsnip#anonymous"](args.body) -- Per `vsnip`
            -- require('luasnip').lsp_expand(args.body) -- Per `luasnip`
        end,
    },
    mapping = {
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
        ['<M-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' }, -- Per suggerimenti LSP
        { name = 'buffer' },   -- Per suggerimenti basati sul buffer
    })
})

local lsp_servers = {
    pyright = {},
    tsserver = {},
    -- clangd = {},
    -- gopls = {},
}

function OffLspServers()
    local clients = vim.lsp.get_active_clients()
    for _, client in ipairs(clients) do
        client.stop()
    end
    require("notify")("Server LSP Spento", "info", {timeout=1000})
end

local opts = {noremap=true, silent=true}
vim.diagnostic.config({
  signs = true,
  underline = true,
})

local view = false
function viewError() 
    view = not view
    vim.diagnostic.config({virtual_text = view})
end

vim.keymap.set('n', '<leader><leader>lp', ':lua require("lspconfig").pyright.setup(require("core.lsp_server.pyright"))<CR>', opts)
vim.keymap.set('n', '<leader><leader>lj', ':lua require("lspconfig").ts_ls.setup({})<CR>', opts)
vim.keymap.set('n', '<leader><leader>lo', ':lua OffLspServers()<CR>', opts)
vim.keymap.set('n', '<leader>view', ':lua viewError()<CR>', opts)
