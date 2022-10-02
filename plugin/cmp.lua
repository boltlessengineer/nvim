local ok, cmp = pcall(require, 'cmp')
if not ok then return end

local snip_ok, luasnip = pcall(require, 'luasnip')
if snip_ok then
  luasnip.filetype_extend('dart', { 'flutter' })
  require('luasnip.loaders.from_vscode').lazy_load()
end

-- TODO: snippet help signs (where could I go)

-- TODO: Warn 'Need check nil.' in LuaJIT..? only happens with require'cmp'
-- cmp = cmp or {}
cmp.setup {
  snippet = {
    expand = function(args)
      if snip_ok then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  window = {
    -- cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-k>'] = cmp.mapping.scroll_docs(-1),
    ['<C-j>'] = cmp.mapping.scroll_docs(1),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      elseif luasnip.expand_or_jumpable() then
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
    { name = 'nvim_lua' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  }),
}

-- TODO: maybe add cmp_git?

-- TODO: fix confict with cmdheight=0
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
