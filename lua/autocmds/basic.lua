local aug = function(group_name, clear)
  if clear == nil then clear = true end
  return vim.api.nvim_create_augroup(group_name, { clear = clear })
end

local au = vim.api.nvim_create_autocmd

-- Hybrid line numbers (inspired by https://jeffkreeftmeijer.com/vim-number/)
-- I know, vim script is much shorter
local numbertoggle = aug 'numbertoggle'
au({ 'BufEnter', 'FocusGained', 'WinEnter' }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number and (vim.fn.mode() ~= 'i') then
      vim.wo.relativenumber = true
      vim.wo.cursorline = true
    end
  end,
})
au({ 'BufLeave', 'FocusLost', 'WinLeave' }, {
  group = numbertoggle,
  callback = function()
    if vim.wo.number then
      vim.wo.relativenumber = false
      vim.wo.cursorline = false
    end
  end,
})

-- Terminal-specific options
au('TermOpen', {
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = 'no'
    -- Use toggleterm.nvim with option below
    vim.wo.winfixheight = true
  end
})

-- Quit UI windows with 'q'
local UIWindow = aug 'UIWindow'
au({ 'FileType' }, {
  group = UIWindow,
  pattern = {
    'help',
    'man',
    'lspinfo',
    'tsplayground',
  },
  callback = function(args)
    if args.pattern ~= 'help' then
      vim.keymap.set('n', '<ESC>', ':q<CR>', { buffer = args.buf })
    end
    vim.keymap.set('n', 'q', ':q<CR>', { buffer = args.buf })
    vim.bo.buflisted = false
  end,
})

-- Changing colorscheme
local UserColorScheme = aug 'UserColorScheme'
au('ColorSchemePre', {
  group = UserColorScheme,
  callback = function(opts)
    local colorscheme = opts.match:gsub('%-', '%_')
    local c_config = 'boltless.colorscheme.' .. colorscheme
    package.loaded[c_config] = nil
    pcall(require, c_config)
  end
})

-- vim.cmd([[autocmd VimEnter * if argc() == 0 | vert help news | exec '79wincmd|' | endif]])

-- TODO: hide save message & notify with nvim-notify
--       https://stackoverflow.com/q/18396759/13150270
