local ok, cmp = pcall(require, 'cmp')
if not ok then return end

local snip_ok, luasnip = pcall(require, 'luasnip')
if snip_ok then
  luasnip.filetype_extend('dart', { 'flutter' })
  require('luasnip.loaders.from_vscode').lazy_load()
end

-- TODO: snippet help signs (show jumpable places)
-- TODO: autocomplete based on context
-- f.e. cmp_path only inside string

cmp.setup {
  snippet = {
    expand = function(args)
      if snip_ok then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.scroll_docs(-1),
    ['<C-j>'] = cmp.mapping.scroll_docs(1),
    -- TODO: don't select-confirm only when match is already exactly same
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,

      -- copied from cmp-under-comparator (found in TJ's config)
      function (entry1, entry2)
        local _, entry1_under = entry1.completion_item.label:find("^_+")
        local _, entry2_under = entry2.completion_item.label:find("^_+")
        entry1_under = entry1_under or 0
        entry2_under = entry2_under or 0
        if entry1_under > entry2_under then
          return false
        elseif entry1_under < entry2_under then
          return true
        end
      end,

      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  window = {
    completion = cmp.config.window.bordered({
      -- TODO: change two options based on vim.g.borderstyle
      border = "none",
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
      col_offset = -3,
    }),
    -- documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local icons = require 'boltless.ui.icons'
      vim_item.kind = icons.kind[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        nvim_lua = '[api]',
        luasnip  = '[Snp]',
        buffer   = '[buf]',
        path     = '[dir]',
        cmdline  = '[cmd]',
      })[entry.source.name]
      local function trim(text)
        -- 10 is for kind & sources width
        local max = (vim.go.columns / 2) - 10
        if text and text:len() > max then
          text = text:match("[^(]+") .. '('
          if text:len() > max then
            text = text:sub(1, max) .. "…"
          end
        end
        return text
      end

      vim_item.abbr = trim(vim_item.abbr)
      return vim_item
    end
  },
}

-- TODO: show buffer based conmpletions in comment

-- TODO: maybe add cmp_git?

-- TODO: fix confict with cmdheight=0
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- TODO: show completion after 3 inputs (not when `:wq`)
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  completion = {
    keyword_length = 2,
  },
  sources = {
    { name = 'path' },
    { name = 'cmdline' },
  },
})
