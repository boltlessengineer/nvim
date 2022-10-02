local ok, comment = pcall(require, 'Comment')
if not ok then return end

comment.setup {
  mappings = {
    basic = false,
    extra = false,
    extended = false,
  },
  pre_hook = function(ctx)
    local inlay_ok, _ = pcall(require, 'lsp-inlayhints')
    if inlay_ok then
      -- TODO: check if this works
      local line_start = ctx.range.srow
      local line_end = ctx.range.erow
      require('lsp-inlayhints.core').clear(0, line_start, line_end)
    end

    local ts_ok, _ = pcall(require, 'ts_context_commentstring')
    if not ts_ok then return end
    require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
  end,
}

require('keymaps.external').comment()
