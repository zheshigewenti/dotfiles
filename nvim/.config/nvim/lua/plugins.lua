local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
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
 {'nvim-telescope/telescope.nvim',tag = '0.1.0',dependencies = 'nvim-lua/plenary.nvim' },

 -- theme
 {'sainnhe/everforest',lazy = false,},
 -- {'kdheepak/monochrome.nvim',lazy = false,},
 'lewis6991/gitsigns.nvim',
 'nvim-treesitter/nvim-treesitter',

 -- tmux
 'preservim/vimux',

 -- git
 --'tpope/vim-fugitive',
 {'kdheepak/lazygit.nvim',dependencies = 'nvim-lua/plenary.nvim'},

  --rust
 'mfussenegger/nvim-dap',
 'rcarriga/nvim-dap-ui',
 'simrat39/rust-tools.nvim',

  --completion
 --"github/copilot.vim",


 'hrsh7th/nvim-cmp',
 'hrsh7th/cmp-nvim-lsp',
 'saadparwaiz1/cmp_luasnip',
 "rafamadriz/friendly-snippets",
 'L3MON4D3/LuaSnip',

 "williamboman/mason.nvim",
 "williamboman/mason-lspconfig.nvim",
 "neovim/nvim-lspconfig",
 -- "glepnir/lspsaga.nvim",






}

local opts = {}

require("lazy").setup(plugins, opts)
