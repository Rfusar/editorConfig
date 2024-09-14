require("csvlens").setup({
    direction = "float", -- "float" | "vertical" | "horizontal" |  "tab"
    exec_path = "csvlens", -- You can specify the path to the executable if you wish. Otherwise, it will use the command in the PATH.
    exec_install_path = vim.fn.stdpath("data") .. "/csvlens.nvim/", -- directory to install the executable to if it's not found in the exec_path, ends with /
})
