--base
-- vim.keymap.set({ 'n', 'v', 'o' },'H', '^')
-- vim.keymap.set({ 'n', 'v', 'o' },'L', '$')
-- vim.keymap.set({ 'n', 'v', 'o' },'J', '5j')
-- vim.keymap.set({ 'n', 'v', 'o' },'K', '5k')

-- vim.keymap.set('n', 'Q', ':q<cr>')
-- vim.keymap.set('n', 'W', ':w<cr>')


-- Use <space> + new arrow keys for moving the cursor around windows
vim.keymap.set('n', '<a-k>', '<c-w>k')
vim.keymap.set('n', '<a-j>', '<c-w>j')
vim.keymap.set('n', '<a-h>', '<c-w>h')
vim.keymap.set('n', '<a-l>', '<c-w>l')

-- Open windows
vim.keymap.set('n', '<a-s>', ':sp<CR>')
vim.keymap.set('n', '<a-v>', ':vs<CR>')

--Disable the default s & ZZ key
-- vim.keymap.set({'n','v'}, 's', '<nop>')
-- vim.keymap.set({'n','v'}, 'S', '<nop>')
-- vim.keymap.set('n', 'ZZ', '<nop>')

--Insert Mode Cursor Movement
vim.keymap.set('i', '<c-a>', '<esc>A')


vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>')
vim.keymap.set('n', '<a-;>', ':Term<CR>')
