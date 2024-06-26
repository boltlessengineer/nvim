local M = {
  clangd = {},
  cssls = {},
  dartls = {},
  emmet_language_server = {},
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
  -- html = {},
  gopls = {},
  ruff_lsp = {},
  rust_analyzer = {
    cargo = {
      buildScripts = {
        -- enable = true,
      }
    }
  },
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
          globals = { "vim" },
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
  -- volar = {
  --   filetypes = {
  --     "javascript",
  --     "typescript",
  --     "javascriptreact",
  --     "typescriptreact",
  --     "vue",
  --     "json",
  --   },
  --   -- on_new_config = function(new_config, new_root_dir)
  --   --   new_config.init_options.typescript.tsdk = "/path/to/tsserver"
  --   -- end
  -- },
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
