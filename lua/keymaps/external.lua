local M = {}

-- 5.1 compatibility (I hate LuaJIT)
table.unpack = table.unpack or unpack

-- local set = vim.keymap.set
local function set_maps(mode, maps, opts)
  opts = opts or {}
  for _, map in ipairs(maps) do
    local lhs, rhs, desc, l_opts = table.unpack(map)
    if l_opts then
      vim.tbl_deep_extend('force', l_opts, opts)
    end
    opts.desc = desc
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- LSP
function M.lsp(opts)
  set_maps('n', {
    { '<space>ld', vim.lsp.buf.definition, 'Go to Definition' },
    { '<space>lr', vim.lsp.buf.rename, 'Rename' },
    { '<space>la', vim.lsp.buf.code_action, 'Code Action' },
    { 'K', vim.lsp.buf.hover, 'Hover Document' },
    -- TODO: <space>lm for LSP menu (turn on/off AutoFormat, etc)
  }, opts)
end

-- Trouble
function M.trouble()
  set_maps('n', {
    { '<space>tt', '<cmd>TodoTrouble keywords=TODO,FIX<CR>', 'List TODOs' },
    { '<space>ti', '<cmd>TodoTrouble keywords=IDEA<CR>', 'List IDEAs' },
  })
end

-- Telescope
function M.telescope()
  set_maps('n', {
    { '<space>ff', '<cmd>Telescope find_files<CR>', 'Find files' },
    { '<space>fo', '<cmd>Telescope oldfiles<CR>', 'Recent files' },
    { '<space>fg', '<cmd>Telescope live_grep<CR>', 'Live Grep' },
    { '<space>b', '<cmd>Telescope buffers<CR>', 'Find Buffers' },
    { '<space>h', '<cmd>Telescope help_tags<CR>', 'Help' },
    { '<space>e', '<cmd>Telescope file_browser<CR>', 'File Browser' },
  })
end

-- NvimTree
function M.nvimtree()
  set_maps('n', {
    { '<C-e>', '<cmd>NvimTreeToggle<CR>', 'FileTree' },
  })
end

-- Comments
function M.comment()
  local api = require('Comment.api')
  set_maps('n', {
    { [[<C-/>]], api.toggle.linewise.current, 'Comment Linewise' },
    { [[<C-\>]], api.toggle.blockwise.current, 'Comment Blockwise' },
  })
  set_maps('v', {
    { [[<C-/>]], '<Plug>(comment_toggle_linewise_visual)', 'Comment Linewise' },
    { [[<C-\>]], '<Plug>(comment_toggle_blockwise_visual)', 'Comment Blockwise' },
  })
end

-- Git
function M.git()
  set_maps('n', {
    { '<space>gj', '<cmd>Gitsigns next_hunk<CR>', 'Next Hunk' },
    { '<space>gk', '<cmd>Gitsigns prev_hunk<CR>', 'Prev Hunk' },
  })
end

return M
