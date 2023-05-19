-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd([[let $LANG='en_US.UTF-8']])

vim.o.mouse = "nv"
vim.o.cmdheight = 0
-- vim.o.foldcolumn = "1"
vim.o.colorcolumn = "80"
vim.o.scrolloff = 5
vim.o.sidescrolloff = 15
vim.o.timeoutlen = 200
vim.o.showtabline = 1
vim.o.laststatus = 3
vim.o.pumblend = 0

if vim.fn.has("nvim-0.9") == 1 then
  vim.opt.diffopt:append({
    "linematch:60",
  })
end

-- stylua: ignore
vim.opt.fillchars = {
  foldopen  = "",
  foldclose = "",
  fold      = " ",
  foldsep   = " ",

  diff      = "╱",
  eob       = " ",

  horiz     = ' ', -- '▁',
  horizup   = '│',
  horizdown = ' ', -- '▁',
  vert      = '│',
  vertleft  = '│',
  vertright = '│',
  verthoriz = '│',
}
vim.o.list = true
vim.opt.listchars = {
  eol = "¬", -- '↵'
  tab = "> ",
}

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

-- vim.o.winbar = "%f %h%w%m%r %=%-14.(%l,%c%V%)%P"
