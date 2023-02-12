local set = vim.keymap.set

vim.g.mapleader = ' '

set('n', '<leader>h', '<cmd>noh | echon<CR>')

set('n', '[b', '<cmd>bprev<CR>')
set('n', ']b', '<cmd>bnext<CR>')

-- window close shortcut
set('n', '<C-q>', '<cmd>close<CR>')
-- TODO: smart close
-- normal mode -> try :close -> try :bdelete
-- terminal mode -> try :close -> try :bprev

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

set('n', 'J', 'mzJ`z')
-- silent to avoid CmdlineEnter event
set('v', 'J', ":m '>+1<CR>gv=gv", { silent = true })
set('v', 'K', ":m '<-2<cr>gv=gv", { silent = true })
-- BUG: % in  ^ here moves cursor to .............^ here

-- copy to system clipboard
set({ "n", "v" }, "<leader>y", [["+y]])
set("n", "<leader>Y", [["+Y]])

-- save with <C-s> and <D-s>
set('n', '<C-s>', '<cmd>w<CR>')
set('n', '<D-s>', '<cmd>w<CR>')

-- TODO: remove this haha
set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>')

-- TODO: more useful keymaps from primeagen
