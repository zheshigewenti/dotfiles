-- Open windows
vim.keymap.set('n', '<a-s>', ':sp<CR>')
vim.keymap.set('n', '<a-v>', ':vs<CR>')

-- Use <space> + new arrow keys for moving the cursor around windows
vim.keymap.set('n', '<a-k>', '<c-w>k')
vim.keymap.set('n', '<a-j>', '<c-w>j')
vim.keymap.set('n', '<a-h>', '<c-w>h')
vim.keymap.set('n', '<a-l>', '<c-w>l')

--Insert Mode Cursor Movement
vim.keymap.set('i', '<c-a>', '<esc>A')


vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>')
vim.keymap.set('n', '<a-;>', ':Term<CR>')
