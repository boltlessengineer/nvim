local M = {}

-- LSP
function M.lsp()
  local autoformat = vim.api.nvim_create_augroup('LspAutoFormat', {})

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- if client.server_capabilities.completionProvider then
      --   vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
      -- end

      -- Attach illuminate
      local il_ok, illuminate = pcall(require, 'illuminate')
      if il_ok then
        illuminate.on_attach(client)
      end

      -- Create buffer-local autocmd for AutoFormat
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = autoformat, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = autoformat,
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({
              bufnr = bufnr,
              filter = function(c)
                return c.name ~= 'tsserver'
              end,
            })
          end
        })
      end

      -- Keymaps
      require('keymaps.external').lsp({ buffer = bufnr })
    end
  })

  vim.api.nvim_create_autocmd('LspDetach', {
    callback = function(args)
      local bufnr = args.buf
      -- Remove buffer-local AutoFormat autocmd
      vim.api.nvim_clear_autocmds({ group = autoformat, buffer = bufnr })
    end
  })
end

-- Packer
function M.packer()
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = 'packer.lua',
    callback = function(args)
      -- TODO: path to packer.lua instead of args.file
      vim.cmd.source(args.file)
    end
  })
end

return M
