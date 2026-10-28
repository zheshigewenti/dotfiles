-- Open windows
vim.keymap.set('n', '<a-s>', ':sp<CR>')
vim.keymap.set('n', '<a-v>', ':vs<CR>')

-- Use <space> + new arrow keys for moving the cursor around windows
vim.keymap.set('n', '<a-k>', '<c-w>k')
vim.keymap.set('n', '<a-j>', '<c-w>j')
vim.keymap.set('n', '<a-h>', '<c-w>h')
vim.keymap.set('n', '<a-l>', '<c-w>l')

-- 插入模式不占用 C-a，把它留给 tmux prefix

-- 终端没有开启 Option as Meta 时的后备键位（Space 是 leader）
vim.keymap.set('n', '<leader>s', ':sp<CR>')
vim.keymap.set('n', '<leader>v', ':vs<CR>')
vim.keymap.set('n', '<leader>h', '<c-w>h')
vim.keymap.set('n', '<leader>j', '<c-w>j')
vim.keymap.set('n', '<leader>k', '<c-w>k')
vim.keymap.set('n', '<leader>l', '<c-w>l')
vim.keymap.set('n', '<leader>t', ':terminal<CR>')

vim.keymap.set('n', '<leader><CR>', ':nohlsearch<CR>')
vim.keymap.set('n', '<a-;>', ':terminal<CR>')
