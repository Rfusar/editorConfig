local M = {}

local OS = vim.loop.os_uname().sysname

if OS == "Windows_NT" then
    M.projects = {
        ["LIB - powershell"] = "C:/Users/Utente/Documents/WindowsPowerShell/Modules",
        ["LIB - nvim"] = "C:/Users/Utente/AppData/Local/nvim",
        ["LIB - python"] = "C:/Users/Utente/Desktop/MyLibrary/MyPackPython",
        ["WORK - KTA"] = "C:/Users/Utente/Desktop/RDP/KTA",
        ["WORK - DoValue - Document Generator"] = "C:/Users/Utente/Desktop/RDP/DoValue/databackbone",
        ["FUNC - Add New Path"] = "",
        ["SYS - Copy Current Directory"] = "",
    }


elseif OS == "Linux" then
    M.projects = {
        ["LIB - powershell"] = "C:/Users/Utente/Documents/WindowsPowerShell/Modules",
        ["LIB - nvim"] = "C:/Users/Utente/AppData/Local/nvim",
        ["LIB - python"] = "C:/Users/Utente/Desktop/MyPackPython",
        ["FUNC - Add New Path"] = "",
        ["SYS - Copy Current Directory"] = "",
    }
end


return M
