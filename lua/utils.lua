---@class bt.util
---@field lsp bt.util.lsp
---@field root bt.util.root
---@field format bt.util.format
---@field plugin bt.util.plugin
---@field notify bt.util.notify
---@field require bt.util.require
local M = {}
setmetatable(M, {
  __index = function (t, k)
    t[k] = require("utils." .. k)
    return t[k]
  end,
})

-- HACK: have no idea how to copy this
local pretty_trace = M.require.on_exported_call("lazy.core.util").pretty_trace
-- HACK: too lazy to copy-paste this
M.merge = M.require.on_exported_call("lazy.core.util").merge

---@param opts? string|{msg:string, on_error:fun(msg)}
function M.try(fn, opts)
  opts = type(opts) == "string" and { msg = opts } or opts or {}
  local msg = opts.msg
  -- error handler
  local error_handler = function(err)
    msg = (msg and (msg .. "\n\n") or "") .. err .. pretty_trace()
    if opts.on_error then
      opts.on_error(msg)
    else
      vim.schedule(function()
        M.notify.error(msg)
      end)
    end
    return err
  end

  ---@type boolean, any
  local ok, result = xpcall(fn, error_handler)
  return ok and result or nil
end

function M.is_win()
  return vim.loop.os_uname().sysname:find("Windows") ~= nil
end

---attach keymaps in specific situation
---@param buffer any
---@param mappings any
---@param filter? fun(LazyKeys):boolean
function M.attach_keymaps(buffer, mappings, filter)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = Keys.resolve(mappings)

  for _, key in pairs(keymaps) do
    if not filter or filter(key) then
      local opts = Keys.opts(key)
      ---@diagnostic disable-next-line: inject-field
      opts.has = nil
      ---@diagnostic disable-next-line: inject-field
      opts.silent = opts.silent ~= false
      ---@diagnostic disable-next-line: inject-field
      opts.buffer = buffer
      vim.keymap.set(key.mode or "n", key.lhs, key.rhs, opts)
    end
  end
end

return M
