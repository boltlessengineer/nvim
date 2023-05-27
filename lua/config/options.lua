-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- lots of help from:
-- - https://github.com/LazyVim/LazyVim
-- - https://github.com/JoosepAlviste/dotfiles

vim.cmd([[let $LANG='en_US.UTF-8']])

vim.opt.diffopt:append({
  "linematch:60",
})
vim.o.clipboard = "unnamedplus"
vim.o.cmdheight = 1
vim.o.colorcolumn = "80"
vim.o.completeopt = "menu,menuone,noselect"
vim.o.conceallevel = 0
vim.o.confirm = true
vim.o.cursorline = true
-- stylua: ignore
vim.opt.fillchars = {
  foldopen  = "",
  foldclose = "",
  fold      = " ",
  foldsep   = " ",

  diff      = "╱",
  eob       = "~",

  horiz     = ' ', -- '▁',
  horizup   = '│',
  horizdown = ' ', -- '▁',
  vert      = '│',
  vertleft  = '│',
  vertright = '│',
  verthoriz = '│',
}
vim.o.foldcolumn = "0"
vim.o.formatoptions = "jcrqlnt"
vim.fn.system("rg --version")
if vim.v.shell_error == 0 then
  vim.o.grepprg = "rg --vimgrep"
end
vim.o.ignorecase = true
vim.o.laststatus = 2
vim.o.list = true
vim.opt.listchars = {
  eol = "¬",
  tab = "  ",
  trail = "·", -- Dot Operator (U+22C5)
  extends = "»", -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  precedes = "«", -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
}
vim.o.mouse = "nv"
vim.o.number = true
vim.o.pumblend = 0
vim.o.pumheight = 10
vim.o.relativenumber = true
vim.o.scrolloff = 5
vim.opt.sessionoptions = { "buffers", "curdir", "folds", "help", "tabpages", "winsize" }
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.opt.shortmess:append({
  W = true, -- Don't print "written" when editing
  I = true, -- No splash screen
  c = true, -- Don't show ins-completion-menu messages (match 1 of 2)
  C = true, -- Don't show messages while scannign ins-completion items (scanning tags)
  s = true, -- Don't show "Search hit BOTTOM" message
})
vim.o.showbreak = "↳ "
vim.o.showmode = false
vim.o.sidescrolloff = 12
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelllang = "en,cjk"
vim.o.splitkeep = "screen"
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.tabstop = 2
vim.o.termguicolors = true
vim.o.timeoutlen = 200
vim.o.undofile = true
vim.o.undolevels = 10000
vim.o.updatetime = 200
vim.o.winminwidth = 10
vim.o.wrap = false

vim.g.mapleader = " "

vim.g.editorconfig = true

-- disable providers (see :h provider)
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

if vim.g.neovide then
  vim.o.guifont = "Fira Code:h16"
  vim.g.neovide_profiler = true
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
