local ok, nvim_lsp = pcall(require, 'lspconfig')
if not ok then return end

require('lspconfig.ui.windows').default_options.border = vim.g.borderstyle

-- TODO: show only one signcolumn with priority Error > Warn > ...
-- TODO: It would be good if I can see server is configured in Mason UI
-- TODO: & Show available server when entered buffer have no server configured.

-- Setup mason-lspconfig first
local mason_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if mason_ok then
  mason_lspconfig.setup {
    ensure_installed = {},

    -- Install lspconfig-configured Language Servers automatically
    automatic_installation = true,
  }
end

require('core.lsp.handlers').setup()

local util = require 'lspconfig.util'
util.on_setup = util.add_hook_after(util.on_setup, function(config)
  -- Add additional capabilities supported by nvim-cmp
  local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_ok then
    config.capabilities = cmp_lsp.default_capabilities()
  end
end)

-- NOTE: on_attach function isn't needed. LspAttach can be used instead in v0.8
require('autocmds.external').lsp()

nvim_lsp.gopls.setup {}
nvim_lsp.sumneko_lua.setup {
  settings = {
    Lua = {
      format = {
        -- NOTE: refer these for configuration documents.
        -- https://github.com/sumneko/lua-language-server/wiki/Code-Formatter
        -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
        defaultConfig = {
          -- quote_style = 'single',
        },
      },
    },
  },
}
