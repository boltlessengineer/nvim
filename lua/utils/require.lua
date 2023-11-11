--- source: https://github.com/tjdevries/lazy-require.nvim
---@class bt.util.require
local M = {}

--- Require on index.
---
--- Will only require the module after the first index of a module.
--- Only works for modules that export a table.
---
--- ```lua
--- -- This is not loaded yet
--- local lazy_mod = util.require.on_index("my_module")
---
--- -- ... some time later
--- lazy_mod.some_var -- <- Only loads the module now
--- ```
---@param modname string
---@return table
function M.on_index(modname)
  -- stylua: ignore
  return setmetatable({}, {
    __index = function(_, key) return require(modname)[key] end,
    __newindex = function(_, key, value) require(modname)[key] = value end,
  })
end

--- Require when an exported method is called.
---
--- Creates a new function. Cannot be used to compare functions,
--- set new values, etc. Only useful for waiting to do the require until you actually
--- call the code.
---
--- ```lua
--- -- This is not loaded yet
--- local lazy_mod = util.require.on_exported_call('my_module')
--- local lazy_func = lazy_mod.exported_func
---
--- -- ... some time later
--- lazy_func(42)  -- <- Only loads the module now
--- 
--- ```
--- Require on exported call
---@param modname string
---@return table
function M.on_exported_call(modname)
  return setmetatable({}, {
    __index = function (_, k)
      return function (...)
        return require(modname)[k](...)
      end
    end
  })
end

return M
