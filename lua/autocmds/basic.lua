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
    if vim.wo.number then
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
local Terminal = aug 'Terminal'
au('TermOpen', {
  group = Terminal,
  callback = function()
    -- TODO: make Issue for lua version of `setlocal`
    -- (`vim.wo[winid]` only works with specific window id)
    vim.cmd [[
      setlocal nonu
      setlocal nornu
      setlocal signcolumn=no
      setlocal nowinfixheight
    ]]
    -- NOTE: Use toggleterm.nvim with 'winfixheight' option
  end
})
au({'TermOpen', 'BufWinEnter', 'WinEnter'}, {
  group = Terminal,
  pattern = 'term://*',
  callback = function()
    vim.cmd.startinsert()
  end,
})
au('BufLeave', {
  group = Terminal,
  pattern = 'term://*',
  callback = function ()
    vim.cmd.stopinsert()
  end,
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
    -- TODO: find why `<ESC>` is mapped to `:q` in help window by somewhere (not here)
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

-- Hide Cursor in windows like NvimTree or QuickFix
local AutoHideCursor = aug 'AutoHideCursor'
-- vim.cmd('set guicursor+=a:Cursor/lCursor')
au('FileType', {
  group = AutoHideCursor,
  callback = function(opts)
    local line_mode_filetypes = {
      "qf",
      "NvimTree",
      "netrw",
    }
    local filetype = vim.bo[opts.buf].filetype
    if vim.tbl_contains(line_mode_filetypes, filetype) then
      vim.cmd('hi Cursor blend=100')
    else
      vim.cmd('hi Cursor blend=0')
    end
  end,
})
au('CmdLineEnter', {
  group = AutoHideCursor,
  callback = function()
    vim.cmd 'hi Cursor blend=0'
  end
})

-- TODO: no idea how to make completion menu more visible with autocmd below
-- IDEA: y-offset=1 for cmp may be a solution

-- show statusline in Command Mode (even when cmdheight=0)
local CmdLine = aug 'CmdLine'
au('CmdlineEnter', {
  group = CmdLine,
  callback = function()
    local original_height = vim.o.cmdheight
    if (vim.o.cmdheight ~= 0) or (not vim.g.cmdheight) or (vim.g.cmdheight == 0) then
      return
    end
    vim.o.cmdheight = vim.g.cmdheight
    au('CmdlineLeave', {
      group = CmdLine,
      callback = function()
        vim.o.cmdheight = original_height
        return true
      end,
    })
  end,
})
