-- Setup nvim-cmp
local cmp = require('cmp')
local C = require('core.console.colors')

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

-- Lista dei server LSP e delle loro configurazioni
local lsp_servers = {
    pyright = {},
    tsserver = {},
    -- clangd = {},
    -- gopls = {},
}

function RebootHelps(start)
    local lsp = require('lspconfig')
    local lettore = ""
    
    if not start then
        lettore = vim.fn.input("Lag: ")
        if lettore == "py" then lsp.pyright.setup{}
        elseif lettore == "js" then lsp.ts_ls.setup{}
        elseif lettore == "off" then
            local clients = vim.lsp.get_active_clients()
            for _, client in ipairs(clients) do
                client.stop()
            end
        end
    else
        lsp.pyright.setup{}
    end
    
    -- Log del risultato
    C.SetColors("RebootHelps Success: " .. lettore, "Success", "[OK]")
end

-- Chiamata della funzione al caricamento
RebootHelps(true)

-- Mappatura dei tasti per attivare `RebootHelps`
vim.keymap.set('n', '<leader><leader>rh', ':lua RebootHelps(false)<CR>', { noremap = true, silent = true })
