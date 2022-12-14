local ok, feline = pcall(require, 'feline')
if not ok then return end

-- IDEAs
-- - Show current file(or folder)'s path on tabline (may include navic)
-- - In case of navic, make additional local-statusline for it (like intellij)
-- - Print messages in additional global-statusline (like fidget maybe?)

local function extract_hl(hl_name)
  local g = vim.api.nvim_get_hl_by_name(hl_name, true);
  -- local c = vim.api.nvim_get_hl_by_name(hl_name, false);
  return {
    fg = g.foreground and string.format('#%06x', g.foreground) or nil,
    bg = g.background and string.format('#%06x', g.background) or nil,
    -- ctermfg = c.foreground,
    -- ctermbg = c.background,
  }
end

--
-- local StatusLine = extract_hl('StatusLine')
-- local GitSignsAdd = extract_hl('GitSignsAdd')
-- local GitSignsChange = extract_hl('GitSignsChange')
-- local GitSignsDelete = extract_hl('GitSignsDelete')

local api = vim.api
local fn = vim.fn
local bo = vim.bo

local icons = require('boltless.ui.icons')
local u = require('ui.utils')

-- Get the names of all current listed buffers
local function get_current_filenames()
  local listed_buffers = vim.tbl_filter(function(bufnr)
    return bo[bufnr].buflisted and api.nvim_buf_is_loaded(bufnr)
  end, api.nvim_list_bufs())

  return vim.tbl_map(api.nvim_buf_get_name, listed_buffers)
end

-- Get unique name for the current buffer
local function get_unique_filename(filename, shorten)
  local filenames = vim.tbl_filter(function(filename_other)
    return filename_other ~= filename
  end, get_current_filenames())

  if shorten then
    filename = fn.pathshorten(filename)
    filenames = vim.tbl_map(fn.pathshorten, filenames)
  end

  -- Reverse filenames in order to compare their names
  filename = string.reverse(filename)
  filenames = vim.tbl_map(string.reverse, filenames)

  local index

  -- For every other filename, compare it with the name of the current file char-by-char to
  -- find the minimum index `i` where the i-th character is different for the two filenames
  -- After doing it for every filename, get the maximum value of `i`
  if next(filenames) then
    index = math.max(unpack(vim.tbl_map(function(filename_other)
      for i = 1, #filename do
        -- Compare i-th character of both names until they aren't equal
        if filename:sub(i, i) ~= filename_other:sub(i, i) then
          return i
        end
      end
      return 1
    end, filenames)))
  else
    index = 1
  end

  -- Iterate backwards (since filename is reversed) until a "/" is found
  -- in order to show a valid file path
  while index <= #filename do
    if filename:sub(index, index) == '/' then
      index = index - 1
      break
    end

    index = index + 1
  end

  return string.reverse(string.sub(filename, 1, index))
end

local c = {
  file_info = {
    provider = function(_, opts)
      opts = opts or {}
      local diagnostic_str, readonly_str, modified_str, icon
      local filename = api.nvim_buf_get_name(0)

      local icon_str, icon_color = require('nvim-web-devicons').get_icon_color(
        fn.expand('%:t'),
        nil,
        { default = true }
      )
      icon = { str = icon_str, hl = { fg = icon_color } }

      -- TODO: change `type` variable name
      local name_type = opts.type or 'unique'
      if filename == '' then
        filename = '[No Name]'
      elseif name_type == 'short-path' then
        filename = fn.pathshorten(filename)
      elseif name_type == 'base-only' then
        filename = fn.fnamemodify(filename, ':t')
      elseif name_type == 'relative' then
        filename = fn.fnamemodify(filename, ':~:.')
      elseif name_type == 'relative-short' then
        filename = fn.pathshorten(fn.fnamemodify(filename, ':~:.'))
      elseif name_type == 'unique' then
        filename = get_unique_filename(filename)
      elseif name_type == 'unique-short' then
        filename = get_unique_filename(filename, true)
      elseif name_type ~= 'full-path' then
        filename = fn.fnamemodify(filename, ':t')
      end

      local e = u.diagnostic_count(0, vim.diagnostic.severity.ERROR)
      local w = u.diagnostic_count(0, vim.diagnostic.severity.WARN)
      if e > 0 then
        diagnostic_str = ' ' .. tostring(e)
      elseif w > 0 then
        diagnostic_str = ' ' .. tostring(w)
      else
        diagnostic_str = ''
      end

      if bo.readonly then
        readonly_str = '[RO]'
      else
        readonly_str = ''
      end

      if bo.modified then
        modified_str = '[+]'
      else
        modified_str = ''
      end

      if icon then
        filename = ' ' .. filename
      end

      local str = readonly_str .. modified_str
      if str ~= '' then str = ' ' .. str end

      return string.format('%s%s%s', filename, diagnostic_str, str), icon
    end,
    hl = function()
      local e = u.diagnostic_count(0, vim.diagnostic.severity.ERROR)
      local w = u.diagnostic_count(0, vim.diagnostic.severity.WARN)
      local fg
      if e > 0 then
        fg = extract_hl('DiagnosticSignError').fg
      elseif w > 0 then
        fg = extract_hl('DiagnosticSignWarn').fg
      else
        fg = 'white'
      end
      return { fg = fg }
    end
  },
}

-- Status line
local sl = {
  left = {
    {
      provider = {
        name = 'vi_mode',
      },
      -- hl = {
      --   name = require('feline.providers.vi_mode').get_mode_highlight_name(),
      --   fg = require('feline.providers.vi_mode').get_mode_color(),
      --   style = 'bold',
      -- },
      icon = '',
      left_sep = 'block',
      right_sep = 'block',
    },
    {
      provider = 'git_branch',
      hl = { bg = 'orange' },
      left_sep = 'slant_left',
      right_sep = 'block',
    },
    -- TODO: Git repo info (diff from origin)
    -- NOTE: Check powerline/starship's git status
    {
      provider = '⇡2',
      hl = { bg = 'orange' },
      right_sep = 'slant_right',
    },
    -- TODO: vim.diagnostic.get() for all workspace. not buffers
    -- Diagnostic ERROR count for all buffers
    -- {
    --   provider = function()
    --     return tostring(diagnostic_count(nil, vim.diagnostic.severity.ERROR))
    --   end,
    --   icon = icons.diagnostics.Error .. ' ',
    --   hl = 'DiagnosticSignError',
    --   left_sep = ' ',
    --   right_sep = ' ',
    -- },
    -- -- Diagnostic WARN count for all buffers
    -- {
    --   provider = function()
    --     return tostring(diagnostic_count(nil, vim.diagnostic.severity.WARN))
    --   end,
    --   icon = icons.diagnostics.Warning .. ' ',
    --   hl = 'DiagnosticSignWarn',
    --   right_sep = ' ',
    -- },
  },
  middle = {
  },
  right = {
    -- TODO: prevent wiggling
    -- TODO: LSP diagnostics (not buffer, but whole proj (check trouble.nvim))
    -- NOTE: Check NvimTree & Trouble.nvim & VSCode
    {
      provider = 'lsp_client_names',
      left_sep = ' ',
      right_sep = ' ',
    },
    -- TODO: Mason
    -- TODO: Show Treesitter enable icon
    {
      provider = {
        name = 'file_type',
        opts = {
          filetype_icon = true,
          case = 'lowercase',
        },
      },
      left_sep = ' ',
      right_sep = ' ',
    },
    {
      provider = 'file_encoding',
      left_sep = 'block',
      right_sep = 'block',
    },
    {
      provider = 'position',
      left_sep = 'block',
      right_sep = 'block',
    },
  },
}
local wb = {
  left = {
    -- TODO: set filename in slightly highlighted box
    c.file_info,
  },
  middle = {
  },
  right = {
  },
}

-- TODO: remove feline, move codes to ui/winbar/init.lua
-- ui/winbar/init.lua
--           components.lua
--           utils.lua
-- NOTE: about statusline : https://unix.stackexchange.com/a/518439/543641
-- require('ui.winbar')

-- feline.setup {
--   components = {
--     active   = { sl.left, sl.middle, sl.right },
--     inactive = { sl.left, sl.middle, sl.right },
--   },
-- }
--
-- feline.winbar.setup {
--   components = {
--     active   = { wb.left, wb.middle, wb.right },
--     inactive = { wb.left, wb.middle, wb.right },
--   },
--   disable = {
--     filetypes = {
--       '^NvimTree$',
--       '^packer$',
--     },
--   },
-- }
