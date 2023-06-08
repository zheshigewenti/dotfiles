vim.cmd [[
  let test#strategy = "vimux"
]]

vim.keymap.set('n', '<leader>te', ':TestNearest<CR>')
vim.keymap.set('n', '<leader>T', ':TestFile<CR>')
