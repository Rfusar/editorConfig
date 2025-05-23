local M = {}

local OS = vim.loop.os_uname().sysname

if OS == "Windows_NT" then
    M.projects = {
        ["My Libraries"] = "C:/Users/Utente/Desktop/MyLibrary",
        ["Scrivi Un Emozione"] = "C:/Users/Utente/Desktop/altro/canzoni/testi/Influencer",
        ["WORK - KTA"] = "C:/Users/Utente/Desktop/RDP/KTA",
        ["Update Editor"] = "C:/Users/Utente/AppData/Local/nvim",
        ["WORK - Variables"] = "C:/Users/Utente/Desktop/TEMP_sistema config files",
        ["WORK - DoValue - Document Generator"] = "C:/Users/Utente/Desktop/RDP/DoValue/databackbone",
        ["WORK - Fasdac - FattureV2"] = "C:/Users/Utente/Desktop/RDP/KTA/fasdac/FattureV2",
        ["FUNC - Add New Path"] = "",
        ["FUNC - Add New Snippet"] = "",
        ["FUNC - Add New Script"] = "",
        ["FUNC - Copy Current Directory"] = "",
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
