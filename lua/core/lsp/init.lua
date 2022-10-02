local ok, nvim_lsp = pcall(require, 'lspconfig')
if not ok then return end

-- Setup mason-lspconfig first
local mason_ok, mason_lspconfig = pcall(require, 'mason-lspconfig')
if mason_ok then
  mason_lspconfig.setup {
  }
end
-- TODO: It would be good if I can see server is configured in Mason UI
-- TODO: & Show available server when enter to buffer

local util = require 'lspconfig.util'
util.on_setup = util.add_hook_after(util.on_setup, function(config)
  -- Add additional capabilities supported by nvim-cmp
  local cmp_ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
  if cmp_ok then
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    config.capabilities = cmp_lsp.update_capabilities(capabilities)
  end
end)

-- NOTE: on_attach function isn't needed. LspAttach can be used instead in v0.8
require('autocmds.external').lsp()

nvim_lsp.sumneko_lua.setup {
  -- capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' },

        -- NOTE: diable `different-requires` to hide warnings
        -- https://www.reddit.com/r/neovim/comments/rvc4vo/annoying_lua_warning/
        -- https://www.reddit.com/r/neovim/comments/snmkr3/comment/hw6diw9/
        -- disable = { 'different-requires' },
      },
      format = {
        -- NOTE: refer these for configuration documents.
        -- https://github.com/sumneko/lua-language-server/wiki/Code-Formatter
        -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
        defaultConfig = {
          quote_style = 'single',
        },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
    },
  },
}
