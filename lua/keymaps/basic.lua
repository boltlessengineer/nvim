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
set('c', '<CR>',
  function()
    return vim.fn.getcmdtype() == '/' and '<CR>zzzv' or '<CR>'
  end,
  { expr = true })
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

-- save with <C-s> and <D-s>
set('n', '<C-s>', '<cmd>w<CR>')
set('n', '<D-s>', '<cmd>w<CR>')
