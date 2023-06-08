vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.VM_show_warnings = 0


vim.opt.clipboard='unnamedplus'
vim.opt.backspace = '2'
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.cursorline = false
vim.opt.autoread = true
vim.opt.wildmenu = true
vim.opt.autochdir = true
vim.opt.scrolloff = 4
vim.opt.hlsearch = true
vim.opt.showmode = true
vim.opt.timeout = false
vim.opt.autoindent = false
vim.opt.ttyfast = true
vim.opt.textwidth = 0
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 0
vim.opt.lazyredraw = true
vim.opt.visualbell = true
-- vim.opt.virtualedit ='block'

--fonts
--vim.opt.guifont=Microsoft_YaHei_Mono:h11:cANSI
vim.opt.guifont='wqy-microhei_Mono'


-- windows position
vim.opt.splitright = true
vim.opt.splitbelow = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.cmd [[ set noswapfile ]]

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

--trailing space
vim.opt.list = true
vim.opt.listchars='trail:▫'


--search case
vim.opt.ignorecase = true
vim.opt.smartcase = true
