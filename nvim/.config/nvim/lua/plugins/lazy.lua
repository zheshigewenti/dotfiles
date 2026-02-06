-- =============================================================================
-- 1. Lazy.nvim 引导逻辑
-- =============================================================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },

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
    'gcmt/wildfire.vim',
    'lambdalisue/suda.vim',
    'lewis6991/gitsigns.nvim',
    'kdheepak/lazygit.nvim',
    'dhruvasagar/vim-table-mode',
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
require("luasnip.loaders.from_lua").load({ 
    paths = { vim.fn.expand("~/.config/nvim/snip/") } 
})

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

-- [第三步] 初始化 LSP (修复弃用警告的关键修改)
require("mason").setup()

-- 获取补全能力 (Capabilities)
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- 使用 handlers 自动配置所有服务器，不再手动 require('lspconfig') 循环
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd" }, -- 确保安装这些
    handlers = {
        -- 默认处理器：对所有安装的服务器执行此逻辑
        function(server_name)
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
            })
        end,
        -- 如果需要针对特定语言做特殊配置，可以单独写，例如：
        -- ["lua_ls"] = function() ... end
    }
})

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
