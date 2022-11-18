local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then return end

-- TODO: why 'topdelete' thing isn't working?
gitsigns.setup {
  signs = {
    add          = { text = '▎' }, -- '┃'
    change       = { text = '▎' },
    delete       = { text = '▁' },
    topdelete    = { text = '▔' },
    changedelete = { text = '▁' }, -- '◣'
    -- TODO: reasonable colors for untracked lines
    untracked    = { text = '?' },
  },
  signcolumn = true,
  numhl = false,
  attach_to_untracked = true,
  current_line_blame = true,
  on_attach = function(bufnr)
    require('keymaps.external').git(bufnr)
  end
}
