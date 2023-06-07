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

  'vim-test/vim-test',
  'tpope/vim-commentary',

  'mg979/vim-visual-multi',
  'jiangmiao/auto-pairs',
  'h-hg/fcitx.nvim',
  'lambdalisue/suda.vim',
  {'nvim-telescope/telescope.nvim',tag = '0.1.0',dependencies = 'nvim-lua/plenary.nvim' },

  -- theme
  {'sainnhe/everforest',lazy = false,},
  'nvim-lualine/lualine.nvim',
  'lewis6991/gitsigns.nvim',
  'nvim-treesitter/nvim-treesitter',

  -- tmux
  'preservim/vimux',
  'christoomey/vim-tmux-navigator',

  -- git
  --'tpope/vim-fugitive',
  {'kdheepak/lazygit.nvim',dependencies = 'nvim-lua/plenary.nvim'},

  -- rust
  'mfussenegger/nvim-dap',
  'rcarriga/nvim-dap-ui',
  'simrat39/rust-tools.nvim',

  -- completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  "rafamadriz/friendly-snippets",
  "github/copilot.vim",
  "williamboman/mason.nvim",
  "neovim/nvim-lspconfig",
  "williamboman/mason-lspconfig.nvim",
  "glepnir/lspsaga.nvim",





}

local opts = {}

require("lazy").setup(plugins, opts)
