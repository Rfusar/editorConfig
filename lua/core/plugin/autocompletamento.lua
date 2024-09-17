-- Setup nvim-cmp
local cmp = require('cmp')
local C = require('core.console.colors')

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        end,
    },
    mapping = {
        ['<Down>'] = cmp.mapping.select_next_item(), -- Select the next suggestion
        ['<Up>'] = cmp.mapping.select_prev_item(), -- Select the previous suggestion
        ['<M-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }), -- Trigger autocomplete
        ['<M-y>'] = cmp.config.disable, -- Disable the default mapping for `<C-y>`
        ['<M-e>'] = cmp.mapping({
            i = cmp.mapping.abort(), -- Abort the completion in insert mode
            c = cmp.mapping.close(), -- Close the completion window in command mode
        }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm the currently selected item on pressing `<CR>`
    },
    sources = cmp.config.sources({
        { name = 'vsnip' }, -- For vsnip users
        -- { name = 'luasnip' }, -- For luasnip users
        -- { name = 'ultisnips' }, -- For ultisnips users
        -- { name = 'snippy' }, -- For snippy users
     
        { name = 'buffer' } -- Adds buffer as an additional completion source
    })
})

-- List of LSP servers and their configurations
local lsp_servers = {
    pyright = {},
    tsserver = {},
    -- clangd = {},
    -- gopls = {},
}

-- Function to setup LSP servers and add workspace folder
function RebootHelps()
    local lettore = vim.fn.input("Lag: ")
    if lettore == "py" then
        require('lspconfig').pyright.setup{}
   elseif lettore == "js" then 
        require('lspconfig').tsserver.setup{}
    elseif lettore == "off" then
        local clients = vim.lsp.get_active_clients()
        for _, client in ipairs(clients) do
            client.stop()
        end
    end
    
    C.SetColors("RebootHelps Success "..lettore, "Success", "[OK]")
end

-- Key mapping to trigger RebootHelps
vim.keymap.set('n', '<leader><leader>rh', ':lua RebootHelps()<CR>', {noremap=true, silent=true})
