local util_hl = require("utils.highlights")
local ui = require("config.ui")

local hls = {
  mode_normal = "ViModeNormal",
  mode_insert = "ViModeInsert",
  mode_replace = "ViModeReplace",
  mode_select = "ViModeSelect",
  mode_visual = "ViModeVisual",
  mode_command = "ViModeCommand",
  mode_terminal = "ViModeTerminal",
  base = "Winbar",
  bold = "WinbarBold",
  nc_base = "WinbarNC",
  nc_bold = "WinbarNCBold",
  nontext = "WinbarNonText",
  git_branch = "WinbarBlue",
  diag_error = "WinbarDiagError",
  diag_warn = "WinbarDiagWarn",
  diag_error_sign = "WinbarDiagSignError",
  diag_warn_sign = "WinbarDiagSignWarn",
  stx_keyword = "WinbarKeyword",
  comment = "WinbarComment",
}

local function set_colors()
  -- local fg = { from = "Winbar", attr = "fg" }
  local bg = { from = "Winbar", attr = "bg" }
  -- local ncfg = { from = "WinbarNC", attr = "fg" }
  -- local ncbg = { from = "WinbarNC", attr = "bg" }
  local map = {
    [hls.mode_normal] = { fg = bg, bg = { from = "CursorLineNr", attr = "fg" }, bold = true },
    [hls.mode_insert] = { fg = bg, bg = ui.palette.green, bold = true },
    [hls.mode_terminal] = { fg = bg, bg = ui.palette.green, bold = true },
    [hls.mode_replace] = { fg = bg, bg = ui.palette.red, bold = true },
    [hls.mode_select] = { fg = bg, bg = ui.palette.green, bold = true },
    [hls.mode_visual] = { fg = bg, bg = ui.palette.magenta, bold = true },
    [hls.mode_command] = { fg = bg, bg = ui.palette.yellow, bold = true },

    [hls.bold] = { inherit = hls.base, bold = true },
    [hls.nc_bold] = { inherit = hls.nc_base, bold = true },
    [hls.nontext] = { inherit = hls.base, fg = { from = "NonText" } },
    [hls.comment] = { inherit = hls.base, fg = { from = "Comment" } },

    [hls.git_branch] = { inherit = hls.base, fg = ui.palette.magenta, bold = true },

    [hls.diag_error] = { inherit = hls.base, fg = { from = "DiagnosticError" } },
    [hls.diag_warn] = { inherit = hls.base, fg = { from = "DiagnosticWarn" } },
    [hls.diag_error_sign] = { inherit = hls.base, fg = { from = "DiagnosticSignError" } },
    [hls.diag_warn_sign] = { inherit = hls.base, fg = { from = "DiagnosticSignWarn" } },

    [hls.stx_keyword] = { inherit = hls.base, fg = { from = "Keyword" } },
  }

  local ok, lualine = pcall(require, "lualine.themes." .. (vim.g.colors_name or ""))
  if ok then
    -- map[hls.mode_normal].bg = lualine.normal.a.bg
    map[hls.mode_insert].bg = lualine.insert.a.bg
    map[hls.mode_terminal].bg = lualine.terminal.a.bg
    map[hls.mode_replace].bg = lualine.replace.a.bg
    map[hls.mode_select].bg = lualine.insert.a.bg
    map[hls.mode_visual].bg = lualine.visual.a.bg
    map[hls.mode_command].bg = lualine.command.a.bg
  end

  util_hl.all(map)
end

util_hl.plugin_wrap("winbar", set_colors)

-- stylua: ignore
local vi_mode_names = {
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
  ['rm']    = { 'MORE',      'MOR', 'M' },
  ['r?']    = { 'CONFIRM',   'CFM', 'C' },
  ['!']     = { 'SHELL',     'SHL', 'S' },
  ['t']     = { 'TERMINAL',  'TER', 'T' },
}

-- stylua: ignore
local vi_mode_colors = {
  n       = hls.mode_normal,
  i       = hls.mode_insert,
  v       = hls.mode_visual,
  V       = hls.mode_visual,
  ["\22"] = hls.mode_visual,
  s       = hls.mode_select,
  S       = hls.mode_select,
  ["\19"] = hls.mode_select,
  R       = hls.mode_replace,
  c       = hls.mode_command,
  ["!"]   = hls.mode_terminal,
  t       = hls.mode_terminal,
}

local function is_win_current()
  local winid = vim.api.nvim_get_current_win()
  local curwin = tonumber(vim.g.actual_curwin)
  return winid == curwin
end

local function lsp_attached()
  return #vim.lsp.get_active_clients({ bufnr = 0 }) > 0
end

local function color(hlgroup, content)
  -- TODO: replace with util_hl.hl_text()
  return string.format("%%#%s#%s%%*", hlgroup, content)
end

local function vi_mode()
  if not is_win_current() then
    return "     "
  end
  local mode = vim.fn.mode(1)
  local mode_name = " " .. vi_mode_names[mode][2] .. " "
  local mode_color = vi_mode_colors[mode:sub(1, 1)]
  return color(mode_color, mode_name)
end

local function file_name()
  local j = vim.fs.joinpath
  -- stylua: ignore
  local path = vim.fn.expand("%:p:h")
    :gsub(vim.pesc(j(vim.loop.cwd(), "")), "")
  if path == vim.loop.cwd() then
    path = ""
  else
    path = j(path, "")
  end

  local name = vim.fn.expand("%:p:t")

  local hi = is_win_current() and hls.bold or hls.nc_bold
  -- TODO: make filename shorter using like $DOTFILES, $HOME
  local xdg_config = vim.env.XDG_CONFIG or vim.fs.joinpath(vim.env.HOME, ".config")
  local vim_dotfiles = vim.fs.joinpath(xdg_config, vim.env.NVIM_APPNAME or "nvim", "")
  local paths = {
    [vim.env.VIMRUNTIME] = "$VIMRUNTIME",
    [vim_dotfiles] = "$VIM_DOTFILES",
    [xdg_config] = "$DOTFILES",
    [vim.fs.joinpath(vim.env.HOME, "Projects")] = "$PROJECTS",
  }
  return color(hls.nc_base, path) .. color(hi, name)
end

local function get_git_dict(bufnr)
  bufnr = bufnr or 0
  ---@diagnostic disable-next-line: undefined-field
  local status = vim.b[bufnr].gitsigns_status_dict
  return status
end

-- FIX: when new repo, git_status.head is "".
-- use global head name instead buffer local ones
local function git_status()
  if not is_win_current() then
    return nil
  end
  local status = get_git_dict()
  if not status or not status.added then
    return nil
  end
  vim.b.git_status_str = vim.b.git_status_str or "  "

  local status_str = "[" .. vim.b.git_status_str .. "]"

  return table.concat({
    color(hls.nc_base, "on"),
    color(hls.git_branch, " " .. status.head),
    color(hls.comment, status_str),
  }, " ")
end

---get sign text or fallback to char
---@param sign_name string
---@param fallback? string
---@return string
local function get_sign_text(sign_name, fallback)
  local sign = vim.fn.sign_getdefined(sign_name)
  if sign and sign[1] and sign[1].text then
    return sign[1].text
  else
    return fallback or "  "
  end
end

local function lsp_status()
  if not lsp_attached() then
    return ""
  end
  local error_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.E })
  local warn_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.W })
  local error_sign = get_sign_text("DiagnosticSignError", "E ")
  local warn_sign = get_sign_text("DiagnosticSignWarn", "W ")
  local error_text, warn_text
  if error_count > 0 then
    error_text = color(hls.diag_error_sign, error_sign) .. color(hls.diag_error, error_count)
  else
    error_text = color(hls.nontext, error_sign .. error_count)
  end
  if warn_count > 0 then
    warn_text = color(hls.diag_warn_sign, warn_sign) .. color(hls.diag_warn, warn_count)
  else
    warn_text = color(hls.nontext, warn_sign .. warn_count)
  end
  local text = error_text .. color(hls.nontext, ", ") .. warn_text
  return text
end

local vi_mode_placer = "     "

local function file_modi()
  local text = " "
  if vim.bo.modifiable then
    if vim.bo.modified then
      text = text .. "[+]"
    end
  else
    text = text .. "[-]"
    if vim.bo.readonly then
      text = text .. "[RO]"
    end
  end
  if #text == 1 then
    return ""
  end

  return color(hls.base, text)
end

local function help_file()
  -- TODO: show what section I'm in using tree-sitter
  -- find last `(tag)` from cursor position
  return color(hls.nc_base, ":") .. color(hls.stx_keyword, "help") .. " " .. vim.fn.expand("%:t")
end

local function update_file_git_status(bufnr)
  if not get_git_dict(bufnr) then
    return false
  end

  local filename = vim.api.nvim_buf_get_name(bufnr)

  local result = {}
  vim.fn.jobstart("git status -s" .. filename, {
    stdout_buffered = true,
    on_stdout = function(_, data, _)
      for _, item in ipairs(data) do
        if item and item ~= "" then
          table.insert(result, item)
        end
      end
    end,
    on_exit = function(_, code, _)
      if code > 0 and not result[1] then
        vim.b[bufnr].git_status_str = "--"
        return
      end
      vim.b[bufnr].git_status_str = result[1] --:sub(1, 2)
    end,
  })
end

---@param interval number
---@param task function
local function run_task_on_interval(interval, task)
  local pending_job
  local timer = vim.loop.new_timer()
  if not timer then
    return
  end
  local function callback()
    if pending_job then
      vim.fn.jobstop(pending_job)
    end
    pending_job = task()
  end
  local fail = timer:start(0, interval, vim.schedule_wrap(callback))
  if fail ~= 0 then
    vim.schedule(function()
      vim.notify("Failed to start git update job: " .. fail)
    end)
  end
  return timer
end

-- require("config.autocmds").augroup("Winbar", {
--   event = "BufWinEnter",
--   callback = function(args)
--     if not vim.bo.buflisted then
--       return
--     end
--     local timer = run_task_on_interval(2000, function()
--       update_file_git_status(args.buf)
--     end)
--     if timer then
--       vim.api.nvim_create_autocmd("BufWinLeave", {
--         buffer = args.buf,
--         callback = function()
--           timer:close()
--         end,
--       })
--     end
--   end,
-- })

function _G.winbar()
  local modules = {}
  local buftype = vim.bo.buftype
  local filetype = vim.bo.filetype
  if buftype == "" then
    modules = {
      vi_mode(),
      "  ",
      file_name(),
      file_modi(),
      "  ",
      git_status(),
      "%=",
      "%<",
      "%-14.(" .. lsp_status() .. "%)",
      " ",
      "%P ",
    }
  elseif buftype == "help" then
    modules = {
      vi_mode(),
      "%=",
      help_file(),
      "%=",
      vi_mode_placer,
    }
  elseif buftype == "terminal" then
    modules = {
      vi_mode(),
      "%=Terminal%=",
      vi_mode_placer,
    }
  elseif filetype == "oil" then
    modules = {
      vi_mode(),
      "%=Oil%=",
      vi_mode_placer,
    }
  elseif filetype == "neotest-summary" then
    modules = {
      vi_mode(),
      "%=Test Summary%=",
      vi_mode_placer,
    }
  end
  return table.concat(vim.tbl_filter(function(i)
    return i ~= nil
  end, modules))
end

vim.o.winbar = "%{%v:lua.winbar()%}"
