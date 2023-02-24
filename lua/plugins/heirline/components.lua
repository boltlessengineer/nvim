local utils = require("heirline.utils")
local conds = require("heirline.conditions")

local M = {}

M.vi_mode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  condition = conds.is_active,
  static = {
    -- stylua: ignore
    mode_names = {
      ['n']     = { 'NORMAL',    'NOR', 'N' },
      ['no']    = { 'OPERATOR',  'OP_', 'O' },
      ['nov']   = { 'OPERATOR',  'OP_', 'O' },
      ['noV']   = { 'N·OP',      'N·O', 'O' },
      ['no\22'] = { 'N·OP',      'N·O', 'O' },
      ['niI']   = { 'NORMAL',    'NOR', 'N' },
      ['niR']   = { 'NORMAL',    'NOR', 'N' },
      ['niV']   = { 'NORMAL',    'NOR', 'N' },
      ['nt']    = { 'NORMAL',    'NOR', 'N' },
      ['ntT']   = { 'NORMAL',    'NOR', 'N' },
      ['v']     = { 'VISUAL',    'VIS', 'V' },
      ['V']     = { 'V·LINE',    'V·L', 'X' },
      ['Vs']    = { 'V·LINE',    'V·L', 'X' },
      ['\22']   = { 'V·BLOCK',   'V·B', 'B' },
      ['\22s']  = { 'V·BLOCK',   'V·B', 'B' },
      ['s']     = { 'SELECT',    'SEL', 'S' },
      ['S']     = { 'S·LINE',    'S·L', 'S' },
      ['\19']   = { 'S·BLOCK',   'S·B', 'S' },
      ['i']     = { 'INSERT',    'INS', 'I' },
      ['ic']    = { 'INSERT',    'INS', 'I' },
      ['ix']    = { 'INSERT',    'INS', 'I' },
      ['R']     = { 'REPLACE',   'REP', 'R' },
      ['Rc']    = { 'REPLACE',   'REP', 'R' },
      ['Rx']    = { 'REPLACE',   'REP', 'R' },
      ['Rv']    = { 'V·REPLACE', 'V·R', 'R' },
      ['Rvc']   = { 'V·REPLACE', 'V·R', 'R' },
      ['Rvx']   = { 'V·REPLACE', 'V·R', 'R' },
      ['c']     = { 'COMMAND',   'COM', 'C' },
      ['cv']    = { 'VIM·EX',    'V·E', 'E' },
      ['r']     = { 'PROMPT',    'PRT', 'P' },
      ['rm']    = { 'MORE',      '???', 'M' },
      ['r?']    = { 'CONFIRM',   '???', 'C' },
      ['!']     = { 'SHELL',     '$$$', 'S' },
      ['t']     = { 'TERMINAL',  'TER', 'T' },
    },
    mode_colors = {
      n = "vi_normal",
      i = "vi_insert",
      v = "vi_visual",
      V = "vi_visual",
      ["\22"] = "vi_visual",
      s = "vi_select",
      S = "vi_select",
      ["\19"] = "vi_select",
      c = "vi_command",
      R = "diag_error",
      r = "diag_error",
      ["!"] = "diag_error",
      t = "vi_insert",
    },
  },
  provider = function(self)
    local mode_name
    mode_name = self.mode_names[self.mode][2]
    -- TODO: snippet indicator
    --
    -- local snip_stat = ""
    -- if mode_name == "INS" or mode_name == "SEL" then
    --   local luasnip = require("luasnip")
    --   snip_stat = "-"
    --   if luasnip.expand_or_locally_jumpable() then
    --     snip_stat = snip_stat .. ">"
    --   else
    --     snip_stat = snip_stat .. "-"
    --   end
    --   if luasnip.jumpable(-1) then
    --     snip_stat = "<" .. snip_stat
    --   else
    --     snip_stat = "-" .. snip_stat
    --   end
    -- end
    return " " .. mode_name .. " "
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return {
      fg = "wbr_bg",
      bg = self.mode_colors[mode],
      bold = true,
    }
  end,
}

M.file_icon = {
  condition = function()
    local ok = pcall(require, "nvim-web-devicons")
    return ok
  end,
  init = function(self)
    local filename = vim.api.nvim_buf_get_name(0)
    local extension = vim.fn.fnamemodify(filename, ":e")
    self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
  end,
  hl = function(self)
    if conds.is_active() then
      return { fg = self.icon_color }
    end
  end,
  provider = function(self)
    return self.icon and (self.icon .. " ")
  end,
}

M.space = { provider = " " }
M.space2 = { provider = "  " }
M.make_space = function(spaces)
  return { provider = string.rep(" ", spaces) }
end

M.filename = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  provider = function(self)
    return vim.fn.fnamemodify(self.filename, ":~:.:p")
  end,
}

M.filename_short = {
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(filename, ":t")
  end,
  hl = { bold = true },
}

M.file_modi = {
  provider = function()
    if not vim.bo.modifiable or vim.bo.readonly then
      return " [-]"
    elseif vim.bo.modified then
      return " [+]"
    end
  end,
}

M.filename_block = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  -- M.file_icon,
  utils.insert(M.filename, M.file_modi),
}

M.breadcrumb_sep = {
  provider = " > ",
  hl = { fg = "conceal" },
}
M.align = { provider = "%=" }

M.dirname = {
  init = function(self)
    -- copied from barbecue.nvim
    local children = {}
    local filename = vim.api.nvim_buf_get_name(0)
    local dirname = vim.fn.fnamemodify(filename, ":~:.:h")
    if dirname ~= "." then
      local PATH_SEPARATOR = package.config:sub(1, 1)
      -- add root dir at first
      if dirname:sub(1, 1) == "/" then
        table.insert(children, { provider = "/" })
      end
      -- add protocol name at first
      local protocol_start_index = dirname:find("://")
      if protocol_start_index ~= nil then
        local protocol = dirname:sub(1, protocol_start_index + 2)
        table.insert(children, { provider = protocol })
      end
      -- append sub directories
      local dirs = vim.split(dirname, PATH_SEPARATOR, { trimempty = true })
      for _, dir in ipairs(dirs) do
        table.insert(children, { provider = dir })
        table.insert(children, M.breadcrumb_sep)
      end
    end
    table.insert(children, M.file_icon)
    table.insert(children, M.filename_short)
    self.child = self:new(children, 1)
  end,
  provider = function(self)
    return self.child and self.child:eval() or ""
  end,
}

M.navic = {
  condition = function()
    local ok, navic = pcall(require, "nvim-navic")
    if not ok then
      return false
    end
    return navic.is_available()
  end,
  static = {
    type_hl = {
      File = "Directory",
      Module = "@include",
      Namespace = "@namespace",
      Package = "@include",
      Class = "@structure",
      Method = "@method",
      Property = "@property",
      Field = "@field",
      Constructor = "@constructor",
      Enum = "@field",
      Interface = "@type",
      Function = "@function",
      Variable = "@variable",
      Constant = "@constant",
      String = "@string",
      Number = "@number",
      Boolean = "@boolean",
      Array = "@field",
      Object = "@type",
      Key = "@keyword",
      Null = "@comment",
      EnumMember = "@field",
      Struct = "@structure",
      Event = "@keyword",
      Operator = "@operator",
      TypeParameter = "@type",
    },
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end,
  },
  init = function(self)
    -- TODO: icons' on_click should be opening small floating button below (hide with CursorMoved)
    local bufnr = vim.api.nvim_get_current_buf()
    local data = require("nvim-navic").get_data(bufnr) or {}
    local children = {}
    for i, d in ipairs(data) do
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      -- excape `%`s (elixir) and useless default separators
      local name = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", "")
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
              provider = "…",
            },
          },
          { provider = "" },
        },
        on_click = {
          minwid = pos,
          callback = function(_, minwid)
            local line, col, winnr = self.dec(minwid)
            vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
          end,
          name = "heirline_navic",
        },
      }
      table.insert(children, M.breadcrumb_sep)
      table.insert(children, child)
    end
    self.child = self:new(children, 1)
  end,
  provider = function(self)
    return self.child:eval()
  end,
  -- hl = { fg = "comment" },
  update = { "CursorMoved", "CursorHold" },
  -- update = { "WinNew", "CursorMoved", "VimResized", "CursorHold" },
}

M.git_status = {
  provider = "  main [?] ",
}

local function get_errors(bufnr)
  return vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.E })
end

local function get_warns(bufnr)
  return vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.W })
end

local function get_infos(bufnr)
  return vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.I })
end

local function get_hints(bufnr)
  return vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.H })
end

M.local_diagnostics = {
  init = function(self)
    self.errors = #get_errors(0)
    self.warnings = #get_warns(0)
    self.infos = #get_infos(0)
    self.hints = #get_hints(0)
  end,
  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },
  update = { "DiagnosticChanged", "BufEnter" },
  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.infos > 0 and (self.info_icon .. self.infos .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
}

M.diagnostics = {
  init = function(self)
    self.error = #get_errors()
    self.warn = #get_warns()
  end,
  static = {
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },
  hl = { fg = "stl_nc_fg" },
  on_click = {
    callback = function()
      local ok, trouble = pcall(require, "trouble")
      if not ok then
        vim.notify("Plugin `trouble.nvim` doesn't exist", vim.log.levels.ERROR, { title = "Heirline" })
        return
      end
      trouble.toggle({ mode = "workspace_diagnostics" })
    end,
    name = "heirline_diagnostics",
  },
  {
    provider = function(self)
      return string.format("%s%d", self.error_icon, self.error)
    end,
    hl = function(self)
      if self.error > 0 then
        return "DiagnosticSignError"
      end
    end,
  },
  M.space,
  {
    provider = function(self)
      return string.format("%s%d", self.warn_icon, self.warn)
    end,
    hl = function(self)
      if self.warn > 0 then
        return "DiagnosticSignWarn"
      end
    end,
  },
  update = { "DiagnosticChanged" },
}

M.lsp_list = {
  init = function(self)
    self.clients = {}
    local null_active = false
    for _, client in pairs(vim.lsp.get_active_clients()) do
      if client.name ~= "null-ls" then
        self.clients[#self.clients + 1] = {
          name = client.name,
          attached_buffers = client.attached_buffers,
        }
      else
        null_active = true
      end
    end
    if not null_active then return end
    -- collect all loaded buffers & filetypes
    local loaded = {}
    local filetypes = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) then
        local bo = vim.bo[buf]
        if bo.buftype == "" and bo.filetype ~= "" then
          filetypes[bo.filetype] = filetypes[bo.filetype] or {}
          filetypes[bo.filetype][buf] = true
          loaded[buf] = true
        end
      end
    end
    local null_clients = require("null-ls").get_sources()
    for _, client in ipairs(null_clients) do
      local attached_buffers = {}
      if client.filetypes["_all"] then
        attached_buffers = loaded
      else
        for filetype, bufs in pairs(filetypes) do
          if client.filetypes[filetype] then
            attached_buffers = vim.tbl_extend("force", attached_buffers, bufs)
          end
        end
      end
      local count = 0
      for _, _ in pairs(attached_buffers) do
        count = count + 1
      end
      if count > 0 then
        self.clients[#self.clients + 1] = {
          name = client.name,
          attached_buffers = attached_buffers,
        }
      end
    end
  end,
  {
    -- TODO:
    -- LSP:2
    -- [sumneko_lua +1]
    -- [sumneko_lua stylua]
    init = function(self)
      local children = {}
      for i, client in ipairs(self.clients) do
        if i > 1 then
          table.insert(children, M.space)
        end
        local bufnr = vim.api.nvim_get_current_buf()
        table.insert(children, {
          provider = client.name,
          hl = client.attached_buffers[bufnr] and { fg = "fg" } or { fg = "comment" },
        })
      end
      self.child = self:new(children, 1)
    end,
    provider = function(self)
      if #self.clients < 1 then
        return ""
      end
      return self.child:eval()
    end,
    -- hl = { fg = 'fg', bg = 'bg' },
  },
  update = { "BufEnter", "FileType", "LspAttach", "LspDetach" },
}

M.tabpage = {
  condition = function()
    return #vim.api.nvim_list_tabpages() >= 2
  end,
  provider = function(self)
    local win = vim.api.nvim_tabpage_get_win(self.tabpage)
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)
    if vim.bo[buf].buftype == "help" then
      bufname = "[HELP]"
    elseif bufname == "" then
      bufname = "[NEW]"
    elseif vim.bo[buf].buftype == "terminal" then
      bufname = "[TERM]"
    else
      bufname = vim.fn.fnamemodify(bufname, ":t")
    end
    return string.format("%%%dT %s %%T", self.tabnr, bufname)
  end,
  hl = function(self)
    if self.is_active then
      return "TabLineSel"
    else
      return "TabLine"
    end
  end,
}

M.tablist = {
  utils.make_tablist(M.tabpage),
}

M.line_col = {
  {
    provider = "Ln %l, Col %c",
  },
}

M.tab_size = {
  provider = function()
    local tabstyle = vim.bo.expandtab and "Spaces" or "Tab"
    return string.format("%s: %d", tabstyle, vim.bo.tabstop)
  end,
}

M.file_enc = {
  provider = function()
    local enc = (vim.bo.fenc == "") and "UTF-8" or vim.bo.fenc
    return enc:upper()
  end,
}

M.file_format = {
  provider = function()
    local format = vim.bo.fileformat
    return format == "dos" and "CRLF" or "CR"
  end,
}

M.last_messages = {
  condition = function(self)
    local ok, noice = pcall(require, "noice")
    self.noice = noice
    return ok
  end,
  {
    condition = require("noice").api.status.message.has,
    provider = function()
      return require("noice").api.status.message.get_hl()
    end,
  },
}

return M
