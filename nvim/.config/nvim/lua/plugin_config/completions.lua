require("luasnip.loaders.from_vscode").lazy_load{}

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
