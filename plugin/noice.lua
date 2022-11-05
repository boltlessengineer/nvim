--

-- TODO: activate noice in neovide

if vim.g.neovide then
  vim.schedule(function()
    vim.notify('noice can\'t run on neovide (see #17)')
  end)
  return
end
local ok, noice = pcall(require, 'noice')
if not ok then return end

noice.setup {
  cmdline = {
    enabled = false,
  },
  messages = {
    enabled = false,
    view = 'notify',
  },
  lsp = {
    progress = {
      enabled = false,
    },
    hover = {
      enabled = false,
    },
    signature = {
      enabled = false,
    },
    message = {
      enabled = false,
    },
  },
}
vim.notify('noice setup completed')
