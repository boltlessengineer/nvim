local ok, nvimtree = pcall(require, 'nvim-tree')
if not ok then return end

nvimtree.setup {
  disable_netrw = true,
  hijack_cursor = false,
  open_on_setup = false,
  ignore_ft_on_setup = {
    'alpha',
  },
  open_on_tab = false,
  update_cwd = true,
  renderer = {
    icons = {
      -- git_placement = 'signcolumn',
    },
  },
  view = {
    hide_root_folder = false,
    mappings = {
      custom_only = true,
      list = {
        -- KEYMAPS
        { key = { 'l', '<CR>' }, action = 'edit' },
        { key = 'e', action = 'edit_in_place' },
        { key = 'h', action = 'close_node' },
        { key = 'v', action = 'vsplit' },
        { key = '0', action = 'first_sibling' },
        { key = '$', action = 'last_sibling' },
        { key = 'I', action = 'toggle_git_ignored' },
        { key = 'H', action = 'toggle_dotfiles' },
        { key = 'U', action = 'toggle_custom' },
        { key = 'R', action = 'refresh' },
        { key = 'a', action = 'create' },
        { key = 'd', action = 'remove' },
        { key = 'D', action = 'trash' },
        { key = 'r', action = 'rename' },
        { key = '<C-r>', action = 'full_rename' },
        { key = 'x', action = 'cut' },
        { key = 'c', action = 'copy' },
        { key = 'p', action = 'paste' },
        { key = 'y', action = 'copy_name' },
        { key = 'Y', action = 'copy_path' },
        { key = 'gy', action = 'copy_absolute_path' },
        { key = '?', action = 'toggle_help' },
      },
    },
    float = {
      enable = false,
      open_win_config = {
        relative = 'editor',
        border = 'rounded',
        width = 30,
        height = 30,
        row = 1,
        col = 1,
      },
    },
  },
  diagnostics = {
    enable = true,
  },
  trash = {
    -- TODO check if this work well in linux/macos/windows
    cmd = 'trash',
    require_confirm = true,
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
}

require('keymaps.external').nvimtree()
