local M = {}

function M.use(opts)
  ---@type LazyPlugin[]
  local plugins = {}
  for _, plugin in ipairs(opts) do
    ---@diagnostic disable-next-line: cast-local-type
    plugin = (type(plugin) == 'string') and { plugin } or plugin
    ---@cast plugin LazyPlugin

    for k, v in pairs(opts) do
      if type(k) ~= "number" then
        plugin[k] = vim.F.if_nil(plugin[k], v)
      end
    end
    plugins[#plugins+1] = plugin
  end
  return plugins
end

return M
