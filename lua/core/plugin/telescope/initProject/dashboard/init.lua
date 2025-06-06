local I = require("core.plugin.telescope.initProject.dashboard.lib.initpage")
local C = require("core.plugin.telescope.initProject.dashboard.lib.component")
local L = require("core.plugin.telescope.initProject.dashboard.lib.lib")
 
function t(a) return vim.fn.split(a, "\n")end

local layout = t(I.layout)
local globals =t(I.globals)
local page =t(I.page)
local package =t(I.package)

local navbar_config =t(C.navbar_config)
local navbar =t(C.navbar)
local sidebar_config =t(C.sidebar_config)
local sidebar =t(C.sidebar)

-- LIB
local dropdown_config = t(L.dropdown_config)
local dropdown = t(L.dropdown)
local inputs = t(L.input)
local login = t(L.login)

local postcss =t(I.postcss)
local typescript =t(I.typescript)


function createProject()
    vim.fn.mkdir("myTest/src/app", "p")
    vim.fn.mkdir("myTest/src/app/pageOne", "p")
    vim.fn.mkdir("myTest/src/component", "p")
    vim.fn.mkdir("myTest/src/mylib", "p")

    vim.cmd("cd myTest")
    vim.fn.writefile(package, "package.json", "a")
    vim.fn.writefile(postcss, "postcss.config.mjs", "a")
    vim.fn.writefile(typescript, "tsconfig.json", "a")

    vim.cmd("cd src/app/pageOne")
    vim.fn.writefile({}, "layout.tsx", "a")
    vim.fn.writefile({}, "page.tsx", "a")
    
    vim.cmd("cd ..")
    vim.fn.writefile(globals,"globals.css", "a")
    vim.fn.writefile(layout, "layout.tsx", "a")
    vim.fn.writefile(page, "page.tsx", "a")
    
    vim.cmd("cd ../mylib")
    vim.fn.mkdir("dropdown")
    vim.cmd("cd dropdown")
    vim.fn.writefile(dropdown_config,"config.json", "a")
    vim.fn.writefile(dropdown,"init.tsx", "a")
    vim.cmd("cd ..")


    vim.cmd("cd ../component")
    vim.fn.mkdir("sidebar")
    vim.fn.mkdir("navbar")
    vim.fn.mkdir("login")
    
    vim.cmd("cd sidebar")
    vim.fn.writefile(sidebar_config,"config.json", "a")
    vim.fn.writefile(sidebar, "init.tsx", "a")

    vim.cmd("cd ../login")
    vim.fn.writefile(login,"init.tsx", "a")
    
    vim.cmd("cd ../navbar")
    vim.fn.writefile(navbar_config,"config.json", "a")
    vim.fn.writefile(navbar, "init.tsx", "a")

    vim.cmd("cd ../../../")
    vim.cmd("edit .")
end


vim.api.nvim_create_user_command("CreateNextJS", createProject, {nargs= 0})
