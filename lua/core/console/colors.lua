local M = {}

function M.SetColors(content, color, prefisso)
    vim.api.nvim_set_hl(0, 'Success', { fg = '#09AD00', bg = '#000000', bold = true })
    vim.api.nvim_set_hl(0, 'Warning', { fg = '#FCFC03', bg = '#000000', bold = true })
    vim.api.nvim_set_hl(0, 'Danger', { fg = '#B51225', bg = '#000000', bold = true })

    vim.cmd('echohl '..color..' | echom "'..prefisso..' '..content..'" | echohl None')
end

return M
