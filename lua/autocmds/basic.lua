-- TODO: Use these local functions. Make code simple & more readable
local augroup = function(group_name, clear)
  if clear == nil then clear = true end
  vim.api.nvim_create_augroup(group_name, { clear = clear })
end

local autocmd = vim.api.nvim_create_autocmd

-- Hybrid line numbers (inspired by https://jeffkreeftmeijer.com/vim-number/)
-- I know, vim script is much shorter
local numbertoggle = vim.api.nvim_create_augroup('numbertoggle', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter' }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number and (vim.fn.mode() ~= 'i') then
      vim.wo.relativenumber = true
    end
  end,
})
vim.api.nvim_create_autocmd({ 'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave' }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
    end
  end,
})

-- Terminal-specific options
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'no'
    -- Use toggleterm.nvim with option below
    vim.opt_local.winfixheight = true
  end
})

-- Changing colorscheme
local UserColorScheme = augroup('UserColorScheme')
vim.api.nvim_create_autocmd('ColorSchemePre', {
  group = UserColorScheme,
  callback = function(opts)
    local colorscheme = opts.match:gsub('%-', '%_')
    -- NOTE: We don't have to print error. `:colorscheme` already handles error msg itself
    pcall(require, 'boltless.colorscheme.' .. colorscheme)
  end
})

-- vim.cmd([[autocmd VimEnter * if argc() == 0 | vert help news | exec '79wincmd|' | endif]])

-- TODO: hide save message & notify with nvim-notify
--       https://stackoverflow.com/q/18396759/13150270
