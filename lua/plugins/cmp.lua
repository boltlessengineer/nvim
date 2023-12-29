---@diagnostic disable: missing-fields
return {
  {
    "hrsh7th/nvim-cmp",
    version = false,
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
      "saadparwaiz1/cmp_luasnip",
      "doxnit/cmp-luasnip-choice",
      "lukas-reineke/cmp-under-comparator",
    },
    opts = function()
      local cmp = require("cmp")

      ---@type cmp.ConfigSchema
      return {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-c>"] = cmp.mapping.close(),
          ["<C-j>"] = cmp.mapping.complete(), -- show menu
          ["<c-y>"] = cmp.mapping.confirm({ select = false }),
          ["<cr>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "neorg" },
          { name = "buffer" },
          { name = "path" },
        }),
        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            require("cmp-under-comparator").under,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        formatting = {
          fields = { "abbr", "kind", "menu" },
          format = function(entry, item)
            local icons = require("config.icons").kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            -- stylua: ignore
            item.menu = ({
              nvim_lsp       = "[LSP]",
              luasnip        = "[SNIP]",
              luasnip_choice = "[SNIP]",
              buffer         = "[BUF]",
              path           = "[PATH]",
              emoji          = "[EMOJI]",
              crates         = "[CRATES]",
              npm            = "[NPM]",
              neorg          = "[NEORG]",
              orgmode        = "[ORG]",
              git            = "[GIT]",
            })[entry.source.name]
            return item
          end,
        },
        experimental = {
          ghost_text = false,
        },
      }
    end,
  },
}
