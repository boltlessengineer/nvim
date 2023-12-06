local Util = require("utils")

---@class bt.util.lsp
local M = {}

---@param opts? lsp.Client.filter
function M.get_clients(opts)
  local ret = {} ---@type lsp.Client[]
  if vim.lsp.get_clients then
    ret = vim.lsp.get_clients(opts)
  end
  return opts and opts.filter and vim.tbl_filter(opts.filter, ret) or ret
end

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

-- TODO: run on_rename on Oil.nvim rename event

---@param from string
---@param to string
function M.on_rename(from, to)
  local clients = M.get_clients()
  for _, client in ipairs(clients) do
    if client.supports_method("workspace/willRenameFiles") then
      ---@diagnostic disable-next-line: invisible
      local resp = client.request_sync("workspace/willRenameFiles", {
        files = {
          {
            oldUri = vim.uri_from_fname(from),
            newUri = vim.uri_from_fname(to),
          },
        },
      }, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
end

---copied from https://github.com/neovim/neovim/issues/25869
function M.set_handler_diag_line_sign()
  local diagnostic_lines_ns = vim.api.nvim_create_namespace("Diagnostic Lines")
  local orig_signs_handler = vim.diagnostic.handlers.signs
  local function severity_highlight(severity)
    -- TODO: make highlight from diagnostic highlights
    -- if bg color exists for virtual text, use it
    -- if not, create one by mixing fg color and Normal bg color
    return "DiffDelete"
  end
  vim.diagnositc.handlers.signs = {
    show = function(_, bufnr, _, opts)
      local diagnostics = vim.diagnostic.get(bufnr)
      for _, diagnostic in ipairs(diagnostics) do
        vim.api.nvim_buf_set_extmark(
          diagnostic.bufnr,
          diagnostic_lines_ns,
          diagnostic.lnum,
          0,
          { line_hl_group = severity_highlight(diagnostic.severity) }
        )
      end
      orig_signs_handler.show(diagnostic_lines_ns, bufnr, diagnostics, opts)
    end,
    hide = function(_, bufnr)
      vim.api.nvim_buf_clear_namespace(bufnr, diagnostic_lines_ns, 0, -1)
      orig_signs_handler.hide(diagnostic_lines_ns, bufnr)
    end,
  }
end

---@return _.lspconfig.options
function M.get_config(server)
  local configs = require("lspconfig.configs")
  return rawget(configs, server)
end

---@param server string
---@param cond fun(root_dir, config): boolean
function M.disable(server, cond)
  local util = require("lspconfig.util")
  local def = M.get_config(server)
  ---@diagnostic disable-next-line: undefined-field
  def.document_config.on_new_config = util.add_hook_before(def.document_config.on_new_config, function(config, root_dir)
    if cond(root_dir, config) then
      config.enabled = false
    end
  end)
end

---@alias lsp.Client.filter {id?: number, bufnr?: number, name?: string, method?: string, filter?:fun(client: lsp.Client):boolean}

---@param opts? LazyFormatter| {filter?: (string|lsp.Client.filter)}
function M.formatter(opts)
  opts = opts or {}
  local filter = opts.filter or {}
  filter = type(filter) == "string" and { name = filter } or filter
  ---@cast filter lsp.Client.filter
  ---@type LazyFormatter
  local ret = {
    name = "LSP",
    primary = true,
    priority = 1,
    format = function(buf)
      M.format(Util.merge(filter, { bufnr = buf }))
    end,
    sources = function(buf)
      local clients = M.get_clients(Util.merge(filter, { bufnr = buf }))
      ---@param client lsp.Client
      local ret = vim.tbl_filter(function(client)
        return client.supports_method("textDocument/formatting")
          or client.supports_method("textDocument/rangeFormatting")
      end, clients)
      ---@param client lsp.Client
      return vim.tbl_map(function(client)
        return client.name
      end, ret)
    end,
  }
  return Util.merge(ret, opts) --[[@as LazyFormatter]]
end

---@alias lsp.Client.format {timeout_ms?: number, format_options?: table} | lsp.Client.filter

---@param opts? lsp.Client.format
function M.format(opts)
  opts = opts or {}
  local ok, conform = pcall(require, "conform")
  -- use conform for formatting with LSP when available,
  -- since it has better format diffing
  if ok then
    opts.formatters = {}
    opts.lsp_fallback = true
    conform.format(opts)
  else
    vim.lsp.buf.format(opts)
  end
end

return M
