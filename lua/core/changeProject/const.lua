local M = {}

local OS = vim.loop.os_uname().sysname

if OS == "Windows_NT" then
    M.projects = {
        ["powershell"] = "C:/Users/Utente/Documents/WindowsPowerShell/Modules",
        ["nvim"] = "C:/Users/Utente/AppData/Local/nvim",
        ["python"] = "C:/Users/Utente/Desktop/MyPackPython",
        ["LactalisCheckEmail"] = "C:/Users/Utente/Desktop/eseguibili/checkEmail-lactalis",
        ["LactalisToKofax"] = "C:/Users/Utente/Desktop/eseguibili/toKofax-lactalis",
    }


elseif OS == "Linux" then
    M.projects = {
        ["powershell"] = "C:/Users/Utente/Documents/WindowsPowerShell/Modules",
        ["nvim"] = "C:/Users/Utente/AppData/Local/nvim",
        ["python"] = "C:/Users/Utente/Desktop/MyPackPython",
        ["LactalisDashboard"] = "",
    }
end


return M
