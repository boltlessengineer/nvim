local ok, comment = pcall(require, 'Comment')
if not ok then return end

local pre_hook = function() end
local ts_ok, _ = pcall(require, 'ts_context_commentstring')
if ts_ok then
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
end

comment.setup {
  mappings = {
    basic = false,
    extra = false,
    extended = false,
  },
  pre_hook = pre_hook,
}

require('keymaps.external').comment()
