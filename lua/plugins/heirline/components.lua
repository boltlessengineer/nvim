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
    width = vim.api.nvim_win_get_width(0)
  end
  return width < 80
end

local function is_big()
  local width
  if vim.go.laststatus == 3 then
    width = vim.go.columns
  else
    width = vim.api.nvim_win_get_width(0)
  end
  return width > 120
end

M.align = { provider = '%=' }
M.cutoff = { provider = '%<' }
M.separator = {
  provider = function()
    if is_small() then
      return ' ▏'
    else
      return ' │ '
    end
  end,
  -- hl = { fg = 'dark_fg' },
}
M.space = { provider = ' ' }
M.smartspace = {
  provider = function()
    if not is_small() then
      return '  '
    else
      return ' '
    end
  end,
}

-- TODO: create autocmd group

M.vi_mode = {
  -- TODO: show showcmd or at least recording status here
  -- like: "REC @w"
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
    -- TODO: try copy from lunarvim. (lunarvim -> termguicolors -> etc)
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

-- TODO: show cwd if git is disabled
M.git = {
  condition = function()
    return _G.GitStatus.enabled
  end,
  M.space,
  {
    provider = function()
      return string.format('%s %s',
        icons.git.Branch,
        _G.GitStatus.head
      )
    end,
  },
  {
    -- GitStatus ahead & behind
    condition = function()
      return _G.GitStatus.ahead > 0 or _G.GitStatus.behind > 0
    end,
    provider = function()
      local a = _G.GitStatus.ahead
      local b = _G.GitStatus.behind
      local str = ''
      if a > 0 then str = a .. icons.git.Ahead end
      if b > 0 then str = str .. b .. icons.git.Behind end
      return '(' .. str .. ')'
    end
  },
  M.space,
  hl = { bg = 'section_bg' },
}

M.diagnostics = {
  init = function(self)
    self.error = 0
    self.warn = 0
  end,
  -- TODO: replace color aliases with StatusLine.fg, StatusLine.bg
  hl = { fg = 'nontext', bg = 'bg', force = false },
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
      return string.format('%s%d',
        icons.diagnostics.Error,
        self.error
      )
    end,
    hl = function(self)
      self.error = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.ERROR })
      if self.error > 0 then
        return 'DiagnosticSignError'
      end
    end,
  },
  { provider = ' ' },
  {
    provider = function(self)
      return string.format('%s%d',
        icons.diagnostics.Warning,
        self.warn
      )
    end,
    hl = function(self)
      self.warn = #vim.diagnostic.get(nil, { severity = vim.diagnostic.severity.WARN })
      if self.warn > 0 then
        return 'DiagnosticSignWarn'
      end
    end,
  },
  update = { 'DiagnosticChanged' },
}

M.file_type = {
  provider = function()
    local ft = vim.bo.filetype
    local ignore_filetype = require('boltless.utils.list').ignore_filetype()
    if vim.tbl_contains(ignore_filetype, ft) then ft = 'etc' end
    if ft == '' then ft = 'notype' end
    return ft
    -- for uppercase first letter, `return ft:gsub('^%l', string.upper)`
  end,
  hl = function()
    local buf = vim.api.nvim_get_current_buf()
    local ts_active = vim.treesitter.highlighter.active[buf]
    if not ts_active or vim.tbl_isempty(ts_active) then
      return { fg = 'nontext' }
    end
  end,
}

-- contains file encoding (& file format)
M.file_enc = {
  provider = function()
    local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
    return enc
  end,
  {
    condition = function()
      return is_big()
    end,
    { provider = '[', hl = { fg = 'section_nontext' } },
    {
      provider = function()
        return vim.bo.fileformat
      end,
    },
    { provider = ']', hl = { fg = 'section_nontext' } },
  }
}

M.tabstop = {
  {
    provider = function()
      local text
      if vim.bo.expandtab then
        text = is_big() and 'Spaces' or '␣'
      else
        text = is_big() and 'Tabs' or '↹'
      end
      return text
    end,
  },
  { provider = ':', hl = { fg = 'section_nontext' } },
  {
    provider = function()
      return tostring(vim.bo.tabstop)
    end,
  },
}

local section_sep = {
  provider = M.separator.provider,
  hl = { fg = 'section_nontext' }
}
M.etc = {
  M.smartspace,
  M.tabstop,
  section_sep,
  M.file_enc,
  section_sep,
  M.file_type,
  M.smartspace,
  hl = { bg = 'section_bg' },
}

M.disable_winbar = {
  condition = function()
    return conditions.buffer_matches({
      buftype = require('boltless.utils.list').ignore_buftype(),
      filetype = require('boltless.utils.list').ignore_filetype(),
    })
  end,
  init = function()
    vim.opt_local.winbar = nil
  end
}

M.file = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  hl = { fg = 'fg' },
}

M.file_icon = {
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
    -- NOTE: webdevicons gives icon with 2-cell width
    return self.icon and (self.icon .. ' ')
  end,
}

M.file_name = {
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

M.file_modi = {
  provider = function()
    if not vim.bo.modifiable or vim.bo.readonly then
      return ' [-]'
    elseif vim.bo.modified then
      return ' [+]'
    end
  end,
}

M.file = utils.insert(M.file, {
  M.file_icon,
  M.file_name,
  M.file_modi,
})

M.breadcrumb_sep = {
  provider = icons.ui.ChevronRight,
  hl = { fg = 'nontext' }
}

M.navic = {
  condition = function()
    local ok, navic = pcall(require, 'nvim-navic')
    if not ok then return false end
    return navic.is_available() and conditions.is_active()
  end,
  static = {
    type_hl = {
      File = 'Directory',
      Module = '@include',
      Namespace = '@namespace',
      Package = '@include',
      Class = '@structure',
      Method = '@method',
      Property = '@property',
      Field = '@field',
      Constructor = '@constructor',
      Enum = '@field',
      Interface = '@type',
      Function = '@function',
      Variable = '@variable',
      Constant = '@constant',
      String = '@string',
      Number = '@number',
      Boolean = '@boolean',
      Array = '@field',
      Object = '@type',
      Key = '@keyword',
      Null = '@comment',
      EnumMember = '@field',
      Struct = '@structure',
      Event = '@keyword',
      Operator = '@operator',
      TypeParameter = '@type',
    },
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end
  },
  init = function(self)
    -- TODO: colasped icons' on_click should be opening small floating button below (hide with CursorMoved)
    local data = require('nvim-navic').get_data() or {}
    local children = {}
    for i, d in ipairs(data) do
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      -- excape `%`s (elixir) and buggy default separators
      -- TODO: escape `[~]` things first
      local name = d.name:gsub('%%', '%%%%'):gsub('%s*->%s*', '')
      local child = {
        {
          provider = d.icon,
          hl = self.type_hl[d.type],
        },
        {
          flexible = i,
          { provider = name },
          {
            -- TODO: smart trim (M.disable_w rather than M.disable_)
            provider = string.sub(name, 1, 10),
            {
              provider = '…',
            },
          },
          { provider = '' }
        },
        -- TODO: open float popup when colasped icon is clicked
        on_click = {
          minwid = pos,
          callback = function(_, minwid)
            local line, col, winnr = self.dec(minwid)
            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
          end,
          name = 'heirline_navic',
        },
      }
      table.insert(children, M.breadcrumb_sep)
      table.insert(children, child)
    end
    -- TODO: check how :new() function works (what's the meaning of second parameter `1`)
    self[1] = self:new(children, 1)
  end,
  hl = { fg = 'fg' },
  update = { 'WinNew', 'CursorMoved', 'VimResized' },
}

M.lsp_client_names = {
  init = function(self)
    self.clients = {}
    for _, client in pairs(vim.lsp.get_active_clients()) do
      if client.name ~= 'null-ls' then
        self.clients[#self.clients + 1] = client.name
      end
    end
  end,
  {
    provider = icons.ui.Server,
  },
  -- { provider = '[' },
  {
    -- LSP
    -- [sumneko_lua +1]
    -- [sumneko_lua stylua]
    provider = function(self)
      if #self.clients < 1 then
        return '-'
      end
      return table.concat(self.clients, ' ')
    end,
    hl = { fg = 'fg', bg = 'bg' },
  },
  -- { provider = ']' },
  hl = {
    fg = 'nontext',
    bg = 'bg',
    force = false,
  },
}

return M
