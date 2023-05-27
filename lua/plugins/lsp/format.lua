local M = {}

M.autoformat = vim.F.if_nil(vim.g.autoformat, true)

function M.toggle()
  if vim.b.autoformat == false then
    vim.b.autoformat = nil
    M.autoformat = true
  else
    M.autoformat = not M.autoformat
  end
  if M.autoformat then
    vim.notify("Enabled format on save", vim.log.levels.INFO, { title = "Format" })
  else
    vim.notify("Disabled format on save", vim.log.levels.WARN, { title = "Format" })
  end
end

function M.format()
  if vim.g.format_modi and vim.b._lsp_format_modi_attached then
    -- TODO: use lsp-format-modifications instead
    -- more specific buffer-local-option is needed
    vim.notify("Not configured yet 😅", vim.log.levels.ERROR, { title = "Format" })
    return
  end
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  local have_nls = package.loaded["null-ls"]
    and (#require('null-ls.sources').get_available(ft, "NULL_LS_FORMATTING") > 0)

  vim.lsp.buf.format({
    bufnr = buf,
    filter = function (client)
      if have_nls then
        return client.name == "null-ls"
      end
      return true
    end
  })
end

local augroup = vim.api.nvim_create_augroup('LspAutoFormat', { clear = true })

function M.on_attach(client, buffer)
  if
    client.config
    and client.config.capabilities
    and client.config.capabilities.documentFormattingProvider == false
  then
    return
  end

  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = buffer,
      callback = function ()
        if M.autoformat then
          M.format()
        end
      end
    })
  end
end

return M
