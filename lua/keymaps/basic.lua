local set = vim.keymap.set

set('t', '<C-[>', [[<C-\><C-n>]])
set('t', '<ESC>', '<ESC>')

set('n', '<ESC>', '<cmd>noh | echon<CR>')

set('v', '<', '<gv')
set('v', '>', '>gv')

-- don't yank on paste
set('v', 'p', '"_dP')

-- keep search results centered
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')
