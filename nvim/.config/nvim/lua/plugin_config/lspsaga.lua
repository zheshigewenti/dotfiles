

---- require('lspsaga').setup({
----   code_action_icon = "💡",
----   symbol_in_winbar = {
----     in_custom = true,
----     enable = true,
----     separator = ' ',
----     show_file = false,
----     file_formatter = ""
----   },
---- })

---- vim.keymap.set("n", "gd", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
----vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<cr>', { silent = true })
---- vim.keymap.set({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
---- vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", { silent = true })


