local M = {}

local aug = function(group_name, clear)
  if clear == nil then clear = true end
  vim.api.nvim_create_augroup(group_name, { clear = clear })
end

local au = vim.api.nvim_create_autocmd

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

      -- Attach navic
      if client.server_capabilities.documentSymbolProvider then
        local na_ok, navic = pcall(require, 'nvim-navic')
        if na_ok then
          navic.attach(client, bufnr)
        end
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
      -- TODO: add option questioning to start PackerSync
      -- vim.ui.select({ 'Sync now', 'Not now' }, {
      --   prompt = 'Would you want to sync now?',
      --   format_item = function(item)
      --     return item
      --   end,
      -- }, function(choice)
      --   if choice == 'Sync now' then
      --     vim.schedule(function()
      --       vim.cmd [[PackerSync]]
      --     end)
      --   end
      -- end)
    end
  })
end

-- Heirline
function M.heirline()
  vim.api.nvim_create_autocmd('User', {
    pattern = 'HeirlineInitWinbar',
    callback = function(args)
      local buf = args.buf
      local buftype = vim.tbl_contains(
        require('boltless.utils.list').ignore_buftype(),
        vim.bo[buf].buftype
      )
      if buftype then
        vim.opt_local.winbar = nil
      end
    end,

  })
end

-- NeoVide
function M.neovide()
  local group = aug 'neovide_titlebar'
  au({ 'Colorscheme', 'VimEnter' }, {
    group = group,
    callback = function()
      local bg = vim.api.nvim_get_hl_by_name('Normal', true).background or 0
      local tr = string.format('%02x', vim.g.transparency * 255)
      vim.g.neovide_background_color = string.format('#%06x', bg) .. tr
    end,
  })
end

return M
