--luasnip
require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/snip/" } })



--cmp
local cmp = require("cmp")
cmp.setup{
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
    },

  mapping = cmp.mapping.preset.insert{
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm{ select = true },
      ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
       require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    },

  sources = cmp.config.sources{
      { name = 'nvim_lsp'},
      { name = 'luasnip' },
      { name = 'buffer' },
    },

}

--lsp
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

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

