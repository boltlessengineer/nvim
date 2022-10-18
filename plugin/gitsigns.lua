local ok, gitsigns = pcall(require, 'gitsigns')
if not ok then return end

-- TODO: why 'topdelete' thing isn't working?
gitsigns.setup {
  signcolumn = true,
  numhl = false,
}

require('keymaps.external').git()
