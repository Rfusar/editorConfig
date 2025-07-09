local M = {}

local home = vim.fn.stdpath('config') .. "/lua/core/plugin/telescope/snippets/libs"

local web = home.."/web"
local kta = home.."/KTA"

M.snippets = {
   ["HTML - Default Page"] = home .. "/html.html",
   ["Golang - Server Init"] = home .. "/go_Server1.go",
   ["Golang - Server Utils"] = home .. "/go_Server2.go",
   ["Python - Connect Imap"] = home .. "/py_Imap.py",
   ["Python - script with parameters"] = home .. "/tool_cli.py",
   ["Python - Example of Typification"] = home .. "/type.py",
   ["CSS - Base"] = web .. "/css/style.css",
   ["JS - Utils"] = web .. "/js/utils.js",
   ["JS - DownloadFile"] = web .. "/js/downloadFile.js",
   ["CSharp - KTA - Debug"] = kta .. "/debug.cs",
   ["CSharp - KTA - Main"] = kta .. "/main.cs",
   ["CSharp - KTA - Parser"] = kta .. "/parser.cs",
}
return M
