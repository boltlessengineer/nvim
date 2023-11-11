local M = {
  clangd = {},
  cssls = {},
  dartls = {},
  hls = {
    settings = {
      haskell = {
        formattingProvider = "ormolu",
        checkProject = true,
      },
    },
  },
  jsonls = {
    on_new_config = function(new_config)
      if require("utils").plugin.has("SchemaStore.nvim") then
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
  ruff_lsp = {},
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
          checkThirdParty = "Disable",
        },
      },
    },
  },
  -- yamlls = {
  --   enable = false,
  --   settings = {
  --     yaml = {
  --       on_new_config = function(new_config)
  --         if require("utils").plugin.has("SchemaStore.nvim") then
  --           new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
  --           vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
  --         end
  --       end,
  --       schemaStore = {
  --         enable = false,
  --       },
  --     },
  --   },
  -- },
}
return M
