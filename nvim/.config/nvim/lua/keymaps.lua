--base
vim.keymap.set({ "n", "v", "o" },"H", "^")
vim.keymap.set({ "n", "v", "o" },"L", "$")
vim.keymap.set({ "n", "v", "o" },"J", "5j")
vim.keymap.set({ "n", "v", "o" },"K", "5k")

vim.keymap.set("n", "Q", "<cmd>q<cr>")
vim.keymap.set("n", "W", "<cmd>w<cr>")


-- Use <space> + new arrow keys for moving the cursor around windows
vim.keymap.set('n', '<leader>k', '<c-w>k')
vim.keymap.set('n', '<leader>j', '<c-w>j')
vim.keymap.set('n', '<leader>h', '<c-w>h')
vim.keymap.set('n', '<leader>l', '<c-w>l')

-- Open windows
vim.keymap.set('n', '<a-s>', '<cmd>vsplit<CR>')

--Disable the default s & ZZ key
vim.keymap.set({"n","v"}, "s", "<nop>")
vim.keymap.set("n", "ZZ", "<nop>")

--Insert Mode Cursor Movement
vim.keymap.set('i', '<c-a>', '<esc>A')


vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>')