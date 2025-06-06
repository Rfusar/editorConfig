local key = vim.keymap.set
local opts = { noremap = true, silent = true }



local OS = vim.loop.os_uname().sysname
local path = vim.fn.stdpath("data")

if OS == "Windows_NT" then path = path .. "\\csvlens.nvim\\"
elseif OS == "Linux" then  path = path .. "/site/pack/packer/start/csvlens.nvim/" 
end

require("csvlens").setup({
    direction = "float",
    exec_path = "csvlens",
    exec_install_path = path
})

-- Csv
key('n', "<leader>csv", ":Csvlens<CR>", opts)
-- Markdown
key('n', "<leader>mds", ":MarkdownPreview<CR>", opts)
key('n', "<leader>mdq", ":MarkdownPreviewStop<CR>", opts)
