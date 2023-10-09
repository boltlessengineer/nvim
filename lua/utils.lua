local M = {}

---check if plugin is installed
---@param plugin string
---@return boolean
function M.has_plugin(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

--- source: https://github.com/tjdevries/lazy-require.nvim
--- (yanked from akinsho's dotfiles)

--- Require on index.
---
--- Will only require the module after the first index of a module.
--- Only works for modules that export a table.
---
--- ```lua
--- -- This is not loaded yet
--- local lazy_mod = reqidx("my_module")
---
--- -- ... some time later
--- lazy_mod.some_var -- <- Only loads the module now
--- ```
---@param path string
---@return table
function M.reqidx(path)
  -- stylua: ignore
  return setmetatable({}, {
    __index = function(_, key) return require(path)[key] end,
    __newindex = function(_, key, value) require(path)[key] = value end,
  })
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
  local keymaps = Keys.resolve(mappings)

  for _, key in pairs(keymaps) do
    if not filter or filter(key) then
      local opts = Keys.opts(key)
      opts.has = nil
      opts.silent = opts.silent ~= false
      opts.buffer = buffer
      vim.keymap.set(key.mode or "n", key.lhs, key.rhs, opts)
    end
  end
end

return M
