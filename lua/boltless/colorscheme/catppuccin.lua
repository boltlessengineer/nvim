require('catppuccin').setup {
  term_colors = true,
  integrations = {
    navic = { enabled = true, custom_bg = 'NONE' },
  },
}

vim.g.catppuccin_flavour = 'mocha' -- mocha, macchiato, frappe, latte

vim.cmd.colorscheme('catppuccin')
