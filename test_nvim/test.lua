vim.o.termguicolors = true
require('kanagawa').setup {
  overrides = {
    WinBar = { bg = '#000000' },
  }
}
vim.cmd.colorscheme('kanagawa')
-- vim.api.nvim_set_hl(0, 'WinBar', { fg = '#000000', bg = '#ffffff' })
vim.keymap.set('n', '<space>', function() vim.o.winbar = [[%f]] end)
