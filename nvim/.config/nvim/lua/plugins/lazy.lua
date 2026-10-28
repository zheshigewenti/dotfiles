-- =============================================================================
-- 1. Lazy.nvim 引导逻辑
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- 2. 插件列表
-- =============================================================================
local plugins = {
    -- 基础依赖
    'nvim-lua/plenary.nvim',

    -- 语法解析
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter').install({
                'lua', 'vim', 'vimdoc', 'c', 'cpp', 'go',
                'bash', 'json', 'yaml', 'markdown', 'markdown_inline',
            })
        end,
    },

    -- LSP 管理后端 (必须包含这些)
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",

    -- 补全来源
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'saadparwaiz1/cmp_luasnip',

    -- 代码片段
    { 'L3MON4D3/LuaSnip', version = "v2.41", build = "make install_jsregexp" },
    'rafamadriz/friendly-snippets',

    -- 补全引擎
    'hrsh7th/nvim-cmp',

    -- 其他工具
    'nvim-telescope/telescope.nvim',
    'windwp/nvim-autopairs',
    -- 'tpope/vim-commentary',
    -- 'tpope/vim-surround',
    -- 'mg979/vim-visual-multi',
    'lambdalisue/suda.vim',
    'lewis6991/gitsigns.nvim',
    'kdheepak/lazygit.nvim',
    -- 'dhruvasagar/vim-table-mode',
    'mzlogin/vim-markdown-toc',
    'vim-test/vim-test',
}

-- =============================================================================
-- 3. 运行插件管理器
-- =============================================================================
require("lazy").setup(plugins)

-- =============================================================================
-- 4. 详细配置 (修正警告的核心部分)
-- =============================================================================

-- [第一步] 初始化代码片段 (Snippets)
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
-- 如需 Lua 片段，先创建 ~/.config/nvim/snip/，再取消下面这行
-- require("luasnip.loaders.from_lua").load({ paths = { vim.fn.expand("~/.config/nvim/snip/") } })

-- [第二步] 初始化补全引擎 (CMP)
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
        { name = 'path' },
    })
})

-- [第三步] 初始化 LSP
require("mason").setup()

-- 把 cmp 的能力应用到所有 LSP server（Neovim 0.11+）
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

-- lua_ls 认识 vim 全局，避免误报
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
        },
    },
})

-- mason-lspconfig 2.x 会自动 enable 已安装的 server
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd" },
})

-- gopls 由 Homebrew 安装（Mason 的 GitHub API 在当前网络下不稳定）
vim.lsp.enable({ "gopls" })

-- [第四步] 其他插件初始化
require('gitsigns').setup()
require("nvim-autopairs").setup()
require('telescope').setup()

-- [第五步] 快捷键
vim.keymap.set("n", "<a-g>", "<cmd>LazyGit<cr>")
vim.keymap.set("c", "sw", "w suda://%")
vim.keymap.set('n', '<Space><Space>', require('telescope.builtin').oldfiles, {})
vim.keymap.set('n', '<leader>te', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>T', ':TestFile<CR>')
