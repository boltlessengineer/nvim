---@type lspconfig.options
return {
  clangd = {},
  cssls = {},
  dartls = {},
  tsserver = {},
  svelte = {},
  html = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  -- yamlls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          unusedLocalExclude = { "_*" },
        },
        format = {
          enable = false, -- use stylua istead
        },
        workspace = {
          checkThirdParty = false,
        },
      },
    },
  },
}
