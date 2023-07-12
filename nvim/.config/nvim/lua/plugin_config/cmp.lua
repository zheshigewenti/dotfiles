require("luasnip.loaders.from_vscode").lazy_load{}
-- load snippets from path/of/your/nvim/config/my-cool-snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "$HOME/.config/nvim/snip/" } })

local cmp = require("cmp")
cmp.setup{
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
    },

  mapping = cmp.mapping.preset.insert{
      ['<C-e>'] = cmp.mapping.abort(),
      -- ['<C-j>'] = cmp.mapping.select_next_item(),
      -- ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<CR>'] = cmp.mapping.confirm{ select = true },
    },

  sources = cmp.config.sources{
      { name = 'nvim_lsp'},
      { name = 'luasnip' },
      { name = 'buffer' },
    },

}

local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("lspconfig").lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  }
}


require("lspconfig").clangd.setup {
  capabilities = capabilities,
}

require("lspconfig").rust_analyzer.setup {
  capabilities = capabilities,
}

