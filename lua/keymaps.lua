--base
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

--Disable the default s & ZZ key
vim.keymap.set("n", "s", "<nop>")
vim.keymap.set("n", "ZZ", "<nop>")

--Insert Mode Cursor Movement
vim.keymap.set('i', '<c-a>', '<esc>A')


vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>')
