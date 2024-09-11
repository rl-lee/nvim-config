-- vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt
opt.number = true
opt.relativenumber = true

-- tabs & indentation 
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

--windows
opt.splitright = true
opt.splitbelow = true
