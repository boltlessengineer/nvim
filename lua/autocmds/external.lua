local M = {}

local aug = function(group_name, clear)
  if clear == nil then clear = true end
  return vim.api.nvim_create_augroup(group_name, { clear = clear })
end

local au = vim.api.nvim_create_autocmd

-- LSP
function M.lsp()
  local autoformat = vim.api.nvim_create_augroup('LspAutoFormat', {})

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)

      -- HACK: disable semantic tokens temporarily
      client.server_capabilities.semanticTokensProvider = nil

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
      if client.supports_method('textDocument/rangeFormatting') then
        local fm_ok, format_modi = pcall(require, 'lsp-format-modifications')
        if fm_ok then
          format_modi.attach(client, bufnr, { format_on_save = false })
        end
      end
      -- TODO: create some functions or keymaps
      -- format modifications : <cmd>FormatModifications<CR>
      -- format file          : <cmd>lua vim.lsp.format()<CR>
      -- TODO: unpack this if
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_clear_autocmds({ group = autoformat, buffer = bufnr })
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = autoformat,
          buffer = bufnr,
          callback = function()
            if vim.g.autoformat then
              vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(c)
                  return c.name ~= 'tsserver'
                end,
              })
            end
          end
        })
      end

      -- Keymaps
      require('keymaps.external').lsp(bufnr)
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
      -- TODO: don't when autoformat is on
      vim.cmd.source(args.file)
      vim.ui.select({ 'Sync now', 'Not now' }, {
        prompt = 'Would you want to sync now?',
        format_item = function(item)
          return item
        end,
      }, function(choice)
        if choice == 'Sync now' then
          vim.schedule(function()
            vim.cmd [[PackerSync]]
          end)
        end
      end)
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

-- Alpha
function M.alpha()
  local group = aug 'alpha_tabline'
  au('FileType', {
    group = group,
    pattern = 'alpha',
    callback = function(args)
      local user_opt    = {
        laststatus  = vim.o.laststatus,
        showtabline = vim.o.showtabline,
        ruler       = vim.o.ruler,
        showcmd     = vim.o.showcmd,
      }
      vim.o.laststatus  = 0
      vim.o.showtabline = 0
      vim.o.ruler       = false
      vim.o.showcmd     = false
      au('BufUnload', {
        group = group,
        buffer = args.buf,
        callback = function()
          vim.o.laststatus  = user_opt.laststatus
          vim.o.showtabline = user_opt.showtabline
          vim.o.ruler       = user_opt.ruler
          vim.o.showcmd     = user_opt.showcmd
        end
      })
    end
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
