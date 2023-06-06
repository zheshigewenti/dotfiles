vim.g.mapleader = " "


vim.keymap.set({ "n", "v", "o" },"H", "^")
vim.keymap.set({ "n", "v", "o" },"L", "$")

vim.keymap.set({ "n", "v", "o" },"J", "5j")
vim.keymap.set({ "n", "v", "o" },"K", "5k")

vim.keymap.set("n", "Q", "<cmd>q<cr>")
vim.keymap.set("n", "W", "<cmd>w<cr>")

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
