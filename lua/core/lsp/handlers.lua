local M = {}

function M.setup()
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = vim.g.borderstyle }
  )
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = vim.g.borderstyle,
      -- width = 60,
      -- height = 30,
    }
  )

  -- TODO: belows are diagnostics related config, not LSP. should be moved to lua/core/diagnostics
  local icons = require('boltless.ui.icons')
  local signs = {
    { name = 'DiagnosticSignError', text = icons.diagnostics.Error, numhl = '' },
    { name = 'DiagnosticSignWarn', text = icons.diagnostics.Warning },
    { name = 'DiagnosticSignHint', text = icons.diagnostics.Hint },
    { name = 'DiagnosticSignInfo', text = icons.diagnostics.Information },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.numhl or '' })
  end

end

return M
