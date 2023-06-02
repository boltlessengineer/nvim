---@type lspconfig.options
local M = {
  clangd = {},
  cssls = {},
  dartls = {},
  jsonls = {
    on_new_config = function(new_config)
      if require("utils").has_plugin("SchemaStore.nvim") then
        new_config.settings.json.schemas = new_config.settings.json.schemas or {}
        vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      end
    end,
    settings = {
      json = {
        validate = { enable = true },
      },
    },
  },
  tsserver = {
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  svelte = {},
  html = {},
  gopls = {},
  pyright = {},
  rust_analyzer = {},
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true,
          arrayIndex = "Disable",
          paramType = false,
          setType = true,
        },
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
return M
