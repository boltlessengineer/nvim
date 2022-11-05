-- TODO: change clipboard based on OS
vim.o.clipboard = 'unnamedplus'

-- vim.o.langmenu = 'en_US'
vim.cmd [[let $LANG='en_US.UTF-8']]
vim.o.guifont = 'FiraCode Nerd Font:h16'

vim.o.background = 'dark'

vim.o.title = true -- set gui window's title
vim.o.mouse = 'nv' -- allow the mouse in normal/visual mode
vim.o.showtabline = 1 -- only show tab if there are at least two tab pages
vim.o.laststatus = 3 -- global statusline
vim.o.cmdheight = 0
vim.o.fileencoding = 'utf-8' -- encoding written to the file
vim.o.showmode = false

-- TODO: disable comment smartindent
vim.o.smartindent = true
vim.o.splitbelow = true -- force all horizontal splits to go below current window
vim.o.splitright = true -- force all vertical splits to go to the right of current window
vim.o.expandtab = true -- convert tabs to spaces

vim.o.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.o.tabstop = 2 -- insert 2 spaces for a tab
vim.o.cursorline = true -- highlight the cursorline

vim.o.termguicolors = true -- set term gui colors (most terminals support this)
vim.o.timeoutlen = 200 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.o.updatetime = 100 -- faster completion (4000ms default)

vim.o.number = true -- set numbered line
vim.o.relativenumber = true -- set relative numbered lines
vim.o.numberwidth = 4 -- set number column width to 2 (default 4)
vim.o.signcolumn = 'yes' -- always show the sign column.
vim.o.colorcolumn = '80'
vim.o.wrap = false -- display lines as one long line
vim.o.scrolloff = 5
-- vim.o.sidescrolloff = 8

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

-- TODO: remove VertSplit (winbar can be used instead)
vim.opt.fillchars:append({
  foldopen  = '',
  foldsep   = ' ',
  foldclose = '',
})

if vim.g.borderstyle == 'none' then
  vim.opt.fillchars:append {
    horiz     = '▄',
    horizup   = '▄',
    horizdown = '▄',
    vert      = '█',
    vertleft  = '█',
    vertright = '█',
    verthoriz = '█',
  }
end
