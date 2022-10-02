local ok, feline = pcall(require, 'feline')
if not ok then return end

-- IDEAs
-- - Show current file(or folder)'s path on tabline (may include navic)
-- - In case of navic, make additional local-statusline for it (like intellij)
-- - Print messages in additional global-statusline (like fidget maybe?)

-- Status line
local sl = {
  left = {
    {
      provider = {
        name = 'vi_mode',
      },
      icon = '',
      left_sep = 'block',
      right_sep = 'block',
    },
    {
      provider = 'git_branch',
      left_sep = 'block',
      right_sep = 'block',
    },
    {
      provider = 'git_diff_added',
      left_sep = 'block',
      right_sep = 'block',
    },
    {
      provider = 'git_diff_changed',
      left_sep = 'block',
      right_sep = 'block',
    },
    {
      provider = 'git_diff_removed',
      left_sep = 'block',
      right_sep = 'block',
    },
  },
  middle = {
    -- TODO: prevent wiggling
    {
      provider = {
        name = 'file_info',
        opts = {
          type = 'relative-short',
        },
      },
    },
  },
  right = {
    -- TODO: LSP diagnostics (not buffer, but whole proj (check trouble.nvim))
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
    {
      provider = {
        name = 'file_info',
        opts = {
          file_modified_icon = '[+]',
          type = 'relative',
        },
      },
      left_sep = 'block',
      right_sep = 'block',
    },
    {
      provider = 'diagnostic_errors',
    },
    {
      provider = 'diagnostic_warnings',
    },
    {
      provider = 'diagnostic_hints',
    },
    {
      provider = 'diagnostic_info',
    },
  },
  middle = {
  },
  right = {
  },
}


feline.setup {
  components = {
    active   = { sl.left, sl.middle, sl.right },
    inactive = { sl.left, sl.middle, sl.right },
  },
}

feline.winbar.setup {
  components = {
    active   = { wb.left, wb.middle, wb.right },
    inactive = { wb.left, wb.middle, wb.right },
  },
}
