local M = {}

---run on LspAttach event
---@param cb fun(client, buffer)
function M.on_attach(cb)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
      local buffer = ev.buf
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      cb(client, buffer)
    end,
  })
end

---run on `client` is attached
---@param client string
---@param cb fun(buffer)
function M.on_client_attach(client, cb)
  M.on_attach(function(client_name, buffer)
    if client_name == client then
      cb(buffer)
    end
  end)
end

return M
