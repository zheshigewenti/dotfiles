local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system{
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
 'lunarvim/colorschemes',
 'h-hg/fcitx.nvim',
 'lambdalisue/suda.vim',
 'vim-test/vim-test',
 'windwp/nvim-autopairs',
 'tpope/vim-commentary',
 'mg979/vim-visual-multi',
 'tpope/vim-surround',
 'gcmt/wildfire.vim',
 'gbprod/substitute.nvim',
 'uga-rosa/translate.nvim',
 'nvim-treesitter/nvim-treesitter',
 {'nvim-telescope/telescope.nvim',tag = '0.1.2',dependencies = 'nvim-lua/plenary.nvim' },
 -- markdown
 'dhruvasagar/vim-table-mode',
 'mzlogin/vim-markdown-toc',
 -- tmux
 'preservim/vimux',
 -- git
 'lewis6991/gitsigns.nvim',
 {'kdheepak/lazygit.nvim',dependencies = 'nvim-lua/plenary.nvim'},
  --rust
 'mfussenegger/nvim-dap',
 'rcarriga/nvim-dap-ui',
 'simrat39/rust-tools.nvim',

  --completion
 --"github/copilot.vim",

 "williamboman/mason.nvim",                                --语言服务器管理
 "williamboman/mason-lspconfig.nvim",                      --mason对接lsp友好
 'hrsh7th/nvim-cmp',                                       --代码补全引擎
 'L3MON4D3/LuaSnip',                                       --代码片段引擎
 "neovim/nvim-lspconfig",                                  --lsp服务器设置
 -- "glepnir/lspsaga.nvim",


 'hrsh7th/cmp-nvim-lsp',
 'hrsh7th/cmp-path',
 'saadparwaiz1/cmp_luasnip',
 "rafamadriz/friendly-snippets",
}

local opts = {}

require("lazy").setup(plugins, opts)
