local M = {}

local OS = vim.loop.os_uname().sysname

if OS == "Windows_NT" then
    M.projects = {
        ["My Libraries"] = "C:/Users/Utente/Desktop/MyLibrary",
        ["Scrivi Un Emozione"] = "C:/Users/Utente/Desktop/altro/canzoni/testi/Influencer",
        ["WORK - KTA"] = "C:/Users/Utente/Desktop/RDP/KTA",
        ["Update Nvim"] = "C:/Users/Utente/AppData/Local/nvim",
        ["WORK - Variables"] = "C:/Users/Utente/Desktop/TEMP_sistema config files",
        ["WORK - DoValue - Document Generator"] = "C:/Users/Utente/Desktop/RDP/DoValue/databackbone",
        ["WORK - Fasdac"] = "C:/Users/Utente/Desktop/RDP/KTA/fasdac",
        ["FUNC - Add New Path"] = "",
        ["FUNC - Add New Snippet"] = "",
        ["FUNC - Add New Script"] = "",
    }


elseif OS == "Linux" then
    M.projects = {
        ["LIB - nvim"] = "/home/riccardo/.config/nvim",
        ["My Libraries"] = "/home/riccardo/Scrivania/MyLib",
        ["SYS - Copy Current Directory"] = "",
        ["FUNC - Add New Path"] = "",
        ["FUNC - Add New Snippet"] = "",
        ["FUNC - Add New Script"] = "",
        ["FUNC - Copy Current Directory"] = "",
    }
end


return M
