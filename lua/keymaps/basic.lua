local set = vim.keymap.set

set('t', '<C-[>', [[<C-\><C-n>]])
set('t', '<ESC>', '<ESC>')

set('n', '<ESC>', '<cmd>noh | echon<CR>')

set('v', '<', '<gv')
set('v', '>', '>gv')

-- don't yank on paste
set('x', 'p', '"_dP')

-- keep centered while scrolling
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')
