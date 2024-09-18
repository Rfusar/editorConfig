local C = require('core.console.colors')

local function check_npm()
    -- Verifica se npm è installato
    local handle = io.popen("npm -v")
    local result = handle:read("*a")
    handle:close()

    if result == "" then
        C.SetColors("npm non è installato. Installalo prima di continuare.", "Warning")
        return false
    else
        C.SetColors("npm è installato, versione: " .. result, "Success")
        return true
    end
end

local function install_package(package_name)
    local handle = io.popen("npm list -g " .. package_name)
    local result = handle:read("*a")
    handle:close()

    if result:find(package_name) then
        C.SetColors(package_name .. " è già installato.", "Success")
    else
        C.SetColors("Installazione di " .. package_name, "Warning")
        os.execute("npm install -g " .. package_name)
    end
end

local function setup_environment()
    if not check_npm() then
        return
    end
    local dipendenze = {
        "typescript-language-server", "pyright"
    }
    for _, v in ipairs(dipendenze) do install_package(v) end
end

