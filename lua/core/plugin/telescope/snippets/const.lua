local M = {}

local home = vim.fn.stdpath('config') .. "/lua/core/plugin/telescope/snippets/libs"

M.snippets = {
   ["HTML - Default Page"] = home .. "/html.html",
   ["Golang - Server Init"] = home .. "/go_Server1.go",
   ["Golang - Server Utils"] = home .. "/go_Server2.go",
   ["Python - Connect Imap"] = home .. "/py_Imap.py",
   ["Python - script with parameters"] = home .. "/tool_cli.py",
   ["Python - Example of Typification"] = home .. "/type.py",
   ["CSS - Base"] = home .. "/web/css/style.css",
   ["JS - Utils"] = home .. "/web/js/utils.js",
   ["JS - DownloadFile"] = home .. "/web/js/downloadFile.js",
   ["CSharp - KTA"] = home .. "/KTA-activity.cs",
}
return M
