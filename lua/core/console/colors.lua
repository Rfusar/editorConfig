local M = {}

function M.SetColors(content, color)
    vim.api.nvim_set_hl(0, 'Success', { fg = '#09AD00', bg = '#000000', bold = true })
    vim.api.nvim_set_hl(0, 'Warning', { fg = '#FCFC03', bg = '#000000', bold = true })
    vim.api.nvim_set_hl(0, 'Danger', { fg = '#B51225', bg = '#000000', bold = true })

    local prefisso = ""
    if color == "Success" then prefisso = "[OK]" 
    elseif color == "Warning" then prefisso = "[WARNING]" 
    elseif color == "Danger" then prefisso = "[ERROR]" 
    end

    vim.cmd('echohl '..color..' | echom "'..prefisso..' '..content..'" | echohl None')
end

return M
