local C = require("core.changeProject.const")
local key = vim.keymap.set

function OpenProject()
    for k, _ in pairs(C.projects) do print(tostring(k)) end
    local input = vim.fn.input("\nScegli: ")
    if C.projects[input] then
        vim.fn.chdir(C.projects[input])
        vim.cmd('e .')
    end
end
function OpenProjectNotSaved()
    local path = vim.fn.input("Absolute Path:")
    vim.fn.chdir(path)
    vim.cmd('e .')
end
key("n", "<leader><leader>p", ":lua OpenProject()<CR>", {noremap=true, silent=true})
key("n", "<leader><leader>m", ":lua OpenProjectNotSaved()<CR>", {noremap=true, silent=true})
