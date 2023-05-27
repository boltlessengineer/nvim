local M = {}

---check if plugin is installed
---@param plugin string
---@return boolean
function M.has_plugin(plugin)
  return require("lazy.core.config").plugins[plugin] ~= nil
end

M.root_patterns = { ".git" }

---returns the root directory based on:
---* lsp workspace folders
---* lsp root_dir
---* root pattern of filename of the current buffer
---* root pattern of cwd
---@return string
function M.get_root()
  ---@type string?
  local path = vim.api.nvim_buf_get_name(0)
  path = path ~= "" and vim.loop.fs_realpath(path) or nil
  ---@type string[]
  local roots = {}
  if path then
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
      local workspace = client.config.workspace_folders
      local paths = workspace and vim.tbl_map(function(ws)
        return vim.uri_to_fname(ws.uri)
      end, workspace) or client.config.root_dir and { client.config.root_dir } or {}
      for _, p in ipairs(paths) do
        local r = vim.loop.fs_realpath(p)
        ---@cast r string
        if path:find(r, 1, true) then
          roots[#roots + 1] = r
        end
      end
    end
  end
  table.sort(roots, function(a, b)
    return #a > #b
  end)
  ---@type string?
  local root = roots[1]
  if not root then
    path = path and vim.fs.dirname(path) or vim.loop.cwd()
    ---@type string?
    root = vim.fs.find(M.root_patterns, { path = path, upward = true })[1]
    root = root and vim.fs.dirname(root) or vim.loop.cwd()
  end
  ---@cast root string
  return root
end

---attach keymaps in specific situation
---@param buffer any
---@param mappings any
---@param filter? fun(LazyKeys):boolean
function M.attach_keymaps(buffer, mappings, filter)
  local Keys = require("lazy.core.handler.keys")
  local keymaps = {} ---@type table<string,LazyKeys>

  for _, value in ipairs(mappings) do
    local key = Keys.parse(value)
    if key[2] == vim.NIL or key[2] == false then
      keymaps[key.id] = nil
    else
      keymaps[key.id] = key
    end
  end

  for _, key in pairs(keymaps) do
    if not filter or filter(key) then
      local opts = Keys.opts(key)
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(key.mode or "n", key[1], key[2], opts)
    end
  end
end

return M