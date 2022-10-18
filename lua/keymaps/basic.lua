local set = vim.keymap.set

set('i', 'jk', '<ESC>')
set('i', 'kj', '<ESC>')

set('t', '<ESC>', [[<C-\><C-n>]])
-- set('t', 'jk', [[<C-\><C-n>]])

set('n', '<ESC>', '<cmd>noh | echon<CR>')

set('v', '<', '<gv')
set('v', '>', '>gv')

-- don't yank on paste
set('v', 'p', '"_dP')
