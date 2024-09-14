
local builtin = require('telescope.builtin')

function getGit()
    local res = vim.fn.input("[commits, branches, status] Scelta: ")

    if res == "commits" then builtin.git_commits()
    elseif res == "branches" then builtin.git_branches()
    elseif res == "status" then builtin.git_status()
    end
end

function getSearch()
    local res = vim.fn.input("[files, search] Scelta: ")

    if res == "files" then builtin.find_files()
    elseif res == "search" then builtin.live_grep()
    end
end

vim.keymap.set('n', '<leader>g', getGit, {})
vim.keymap.set('n', '<leader>f', getSearch, {})

vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

builtin.tags()

