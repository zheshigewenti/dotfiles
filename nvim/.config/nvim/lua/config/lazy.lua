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
 'lunarvim/colorschemes',                         -- vi主题
 'h-hg/fcitx.nvim',                               -- 中文输入法
 'lambdalisue/suda.vim',                          -- sw root权限写入
 'vim-test/vim-test',
 'windwp/nvim-autopairs',                         -- 自动双括号
 'tpope/vim-commentary',                          -- gc注释
 'mg979/vim-visual-multi',                        -- 块模式多光标
 'tpope/vim-surround',                            -- cs"'
 'gcmt/wildfire.vim',                             -- enter模块选择
 -- 'gbprod/substitute.nvim',                        --yyss用以替代
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
 -- 'mfussenegger/nvim-dap',
 -- 'nvim-neotest/nvim-nio',
 -- 'rcarriga/nvim-dap-ui',
 -- 'simrat39/rust-tools.nvim',
  --completion
 --"github/copilot.vim",

 "williamboman/mason.nvim",                       --语言服务器管理
 "williamboman/mason-lspconfig.nvim",             --mason对接lsp友好
 'hrsh7th/nvim-cmp',                              --代码补全引擎
 'L3MON4D3/LuaSnip',                              --代码片段引擎
 "neovim/nvim-lspconfig",                         --lsp服务器设置
 -- "glepnir/lspsaga.nvim",


 'hrsh7th/cmp-nvim-lsp',
 'hrsh7th/cmp-path',
 'saadparwaiz1/cmp_luasnip',
 "rafamadriz/friendly-snippets",
}

local opts = {}

require("lazy").setup(plugins, opts)
