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
        hint = {
          enable = true,
          arrayIndex = "Disable",
          setType = true,
          -- paramName = "Disable",
        },
        completion = {
          -- TODO: check what "Replace" means
          keywordSnippet = "Replace",
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
