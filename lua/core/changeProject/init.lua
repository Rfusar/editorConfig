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

key("n", "<leader><leader>p", ":lua OpenProject()<CR>", {noremap=true, silent=true})
