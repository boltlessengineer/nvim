local M = {}

local utils = require('heirline.utils')
local icons = require('boltless.ui.icons')
local conditions = require('heirline.conditions')

-- TODO: combine these two functions
local function is_small()
  local width
  if vim.go.laststatus == 3 then
    width = vim.go.columns
  else
    width = vim.api.nvim_get_mode()
  end
  return width <= 80
end

local function is_big()
  local width
  if vim.go.laststatus == 3 then
    width = vim.go.columns
  else
    width = vim.api.nvim_get_mode()
  end
  return width > 120
end

-- TODO: create autocmd group

M.vi_mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    -- execute this only once, this is required if you want the ViMode
    -- component to be updated on operator pending mode
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', {
        pattern = '*:*o',
        command = 'redrawstatus',
      })
      self.once = true
    end
  end,
  static = {
    mode_names = {
      ['n'] = { 'NORMAL', 'N' },
      ['no'] = { 'OPERATOR', 'OP' },
      ['nov'] = { 'OPERATOR', 'OP' },
      ['noV'] = { 'N·OP', 'OP' },
      ['no\22'] = { 'N·OP', 'OP' },
      ['niI'] = { 'NORMAL', 'N' },
      ['niR'] = { 'NORMAL', 'N' },
      ['niV'] = { 'NORMAL', 'N' },
      ['nt'] = { 'NORMAL', 'N' },
      ['ntT'] = { 'NORMAL', 'N' },
      ['v'] = { 'VISUAL', 'V' },
      ['V'] = { 'V·LINE', 'V·L' },
      ['Vs'] = { 'V·LINE', 'V·L' },
      ['\22'] = { 'V·BLOCK', 'V·B' },
      ['\22s'] = { 'V·BLOCK', 'V·B' },
      ['s'] = { 'SELECT', 'S' },
      ['S'] = { 'S·LINE', 'S·L' },
      ['\19'] = { 'S·BLOCK', 'S·B' },
      ['i'] = { 'INSERT', 'I' },
      ['ic'] = { 'INSERT', 'I' },
      ['ix'] = { 'INSERT', 'I' },
      ['R'] = { 'REPLACE', 'R' },
      ['Rc'] = { 'REPLACE', 'R' },
      ['Rx'] = { 'REPLACE', 'R' },
      ['Rv'] = { 'V·REPLACE', 'V·R' },
      ['Rvc'] = { 'V·REPLACE', 'V·R' },
      ['Rvx'] = { 'V·REPLACE', 'V·R' },
      ['c'] = { 'COMMAND', 'C' },
      ['cv'] = { 'VIM·EX', 'V·E' },
      ['r'] = { 'PROMPT', 'P' },
      ['rm'] = { 'MORE', 'M' },
      ['r?'] = { 'CONFIRM', 'C' },
      ['!'] = { 'SHELL', 'S' },
      ['t'] = { 'TERMINAL', 'T' },
    },
    mode_colors = {
      n = 'fg',
      i = 'green',
      v = 'magenta',
      V = 'magenta',
      ['\22'] = 'magenta',
      s = 'red',
      S = 'red',
      ['\19'] = 'red',
      c = 'yellow',
      R = 'diag_warn',
      r = 'diag_warn',
      ['!'] = 'bright_red',
      t = 'green',
    },
  },
  -- TODO: replace with utils.suround
  provider = function(self)
    local mode_name
    if is_small() then
      mode_name = self.mode_names[self.mode][2]
    else
      mode_name = self.mode_names[self.mode][1]
    end
    return ' ' .. mode_name .. ' '
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return {
      fg = 'bg',
      bg = self.mode_colors[mode],
      bold = true,
    }
  end,
  update = {
    'ModeChanged',
    'VimResized',
  }
}

-- TODO: maybe just use neogit's variables
M.git = {
  condition = function()
    -- Check is git repo & GitStatus is created
    local gitpath = vim.loop.cwd() .. '/.git'
    local ok = vim.loop.fs_stat(gitpath)
    return ok and GitStatus
  end,
  provider = function()
    return string.format('%s %s',
      icons.git.Branch,
      GitStatus.head
    )
  end,
  {
    -- GitStatus ahead & behind
    condition = function()
      return GitStatus.ahead > 0 or GitStatus.behind > 0
    end,
    provider = function()
      local a = GitStatus.ahead
      local b = GitStatus.behind
      local str = ''
      if a > 0 then str = a .. icons.git.Ahead end
      if b > 0 then str = str .. b .. icons.git.Behind end
      return '(' .. str .. ')'
    end
  },
}

M.diagnostics = {
  init = function(self)
    self.error = 0
    self.warn = 0
  end,
  -- TODO: replace color aliases with StatusLine.fg, StatusLine.bg
  hl = { fg = 'fg', bg = 'bg', force = false },
  on_click = {
    callback = function()
      local ok, trouble = pcall(require, 'trouble')
      if not ok then
        vim.notify("Plugin `trouble.nvim` doesn't exist",
          vim.log.levels.ERROR,
          { title = 'Heirline' }
        )
        return
      end
      trouble.toggle({ mode = 'workspace_diagnostics' })
    end,
    name = 'heirline_diagnostics',
  },
  -- NOTE: `hl()` runs first then `provider()`.
  {
    provider = function(self)
      -- self.error = error
      return string.format('%s %d',
        icons.diagnostics.Error,
        self.error
      )
    end,
    hl = function(self)
      self.error = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })
      if self.error > 0 then
        return 'DiagnosticError'
      end
    end,
  },
  { provider = ' ' },
  {
    provider = function(self)
      return string.format('%s %d',
        icons.diagnostics.Warning,
        self.warn
      )
    end,
    hl = function(self)
      self.warn = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN })
      if self.warn > 0 then
        return 'DiagnosticWarn'
      end
    end,
  },
  update = { 'DiagnosticChanged' },
}

M.file_type = {
  provider = function()
    local ft = vim.bo.filetype
    local ignore_filetype = require('boltless.utils.list').ignore_filetype
    if vim.tbl_contains(ignore_filetype, ft) then ft = 'etc' end
    if ft == '' then ft = 'notype' end
    return string.upper(ft)
  end,
  hl = function()
    local buf = vim.api.nvim_get_current_buf()
    local ts_active = vim.treesitter.highlighter.active[buf]
    if not ts_active or vim.tbl_isempty(ts_active) then
      return { fg = 'dark_fg', bg = 'bg' }
    end
  end,
}

-- contains file encoding (& file format)
M.file_info = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    -- return string.format('%s[%s]', enc:upper(), vim.bo.fileformat:upper())
    return enc:upper()
  end,
}

M.tabstop = {
  provider = function()
    local text
    if is_small() then
      text = 'ﲒ'
    else
      if vim.bo.expandtab then
        text = 'Spaces:'
      else
        if is_big() then
          text = 'Tab Size:'
        else
          text = 'Tab:'
        end
      end
    end
    return string.format('%s %d', text, vim.bo.tabstop)
  end,
}

M.disable_winbar = {
  condition = function()
    return conditions.buffer_matches({
      buftype = require('boltless.utils.list').ignore_buftype,
      filetype = require('boltless.utils.list').ignore_filetype,
    })
  end,
  init = function()
    vim.opt_local.winbar = nil
  end
}

M.file_name_block = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
}

local file_icon = {
  condition = function()
    local ok = pcall(require, 'nvim-web-devicons')
    return ok
  end,
  init = function(self)
    local filename = self.filename
    local extension = vim.fn.fnamemodify(filename, ':e')
    self.icon, self.icon_color = require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
  end,
  hl = function(self)
    return { fg = self.icon_color }
  end,
  provider = function(self)
    return self.icon and (self.icon .. ' ')
  end,
}
-- sumiInk1c     = "#1a1a22",

local file_name = {
  provider = function(self)
    local filename = self.filename
    if filename == '' then
      filename = '[No Name]'
    else
      local u = require('boltless.utils.filename')
      local is_short = not conditions.width_percent_below(#filename, 0.25)
      filename = u.get_unique_filename(filename, is_short)
    end
    return filename
  end,
}

M.file_name_block = utils.insert(M.file_name_block,
  file_icon,
  file_name
)

M.navic = {
  condition = function()
    local ok, navic = pcall(require, 'nvim-navic')
    if not ok then return false end
    return navic.is_available()
  end,
  provider = function()
    local navic = require('nvim-navic')
    -- PLAN
    -- 1. escape `%`s and `->`
    -- 2. colaspe icons (calculate max width except filename)
    -- 3. on_click : go to location
  end,
  update = 'CursorMoved',
}

M.align = { provider = '%=' }
M.separator = {
  provider = ' | ',
  hl = { fg = 'sep', bg = 'bg' },
}
-- use separator (`|`) only when window is wide enough
M.smartspace = {
  provider = function()
    if is_small() then
      return ' '
    else
      return ' | '
      -- return '  '
      -- return ' ▏'
    end
  end,
  hl = { fg = 'sep', bg = 'bg' },
}
M.space = { provider = ' ' }

return M
