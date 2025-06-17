local WINDOWS = {"choco", "python", "npm"}
local LINUX = {"wget", "python3", "npm"}

local OS = vim.loop.os_uname().sysname
local dep = {}

if OS == "Windows_NT" then dep = WINDOWS
elseif OS == "Linux" then  dep = LINUX
end

function setup_environment()
    for _, tool in ipairs(dep) do
        local is_installed = vim.fn.executable(tool) == 1
        if is_installed then
            require("notify")(tool .. " è installato", "info", {title = "Dependency Check", timeout = 1000})
        else
            require("notify")(tool .. " non è installato", "error", {title = "Dependency Check", timeout = 1000})
        end
    end
end
