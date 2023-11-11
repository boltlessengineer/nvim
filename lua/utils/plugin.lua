---@class bt.util.plugin
local M = {}

---check if plugin is installed
---@param plugin string
---@return boolean
function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

---@param fn fun()
function M.on_very_lazy(fn)
  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = fn
  })
end

return M
