vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '
vim.g.VM_show_warnings = 0

vim.opt.laststatus =0
-- vim.opt.statusline = "%F%=%l:%c       %P"

vim.opt.clipboard='unnamedplus'
vim.opt.backspace = '2'
-- vim.opt.virtualedit ='block'
-- vim.opt.scrolloff = 4   --term预留4行
vim.opt.textwidth = 0
vim.opt.ttimeoutlen = 0
vim.opt.autowrite = true
vim.opt.autoread = true
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.autochdir = true
vim.opt.hlsearch = true
vim.opt.showmode = true
vim.opt.ttyfast = true
-- vim.opt.lazyredraw = true
vim.opt.visualbell = true
vim.opt.cursorline = false
vim.opt.autoindent = false

--fonts
vim.opt.guifont='wqy-microhei_Mono'
--vim.opt.guifont=Microsoft_YaHei_Mono:h11:cANSI


-- windows cursor position
vim.opt.splitright = true
vim.opt.splitbelow = true

-- use spaces for tabs and whatnot
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true

-- vim.cmd [[ set noswapfile ]]

--Line numbers
vim.wo.number = true
vim.wo.relativenumber = true

--trailing space
vim.opt.list = true
vim.opt.listchars='trail:▫,tab:| '


--search case
vim.opt.ignorecase = true
vim.opt.smartcase = true

