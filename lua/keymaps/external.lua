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
    { 'K', vim.lsp.buf.hover, 'Hover Document' },
    -- TODO: <space>lm for LSP menu (turn on/off AutoFormat, etc)
  }, opts)
end

-- Telescope
function M.telescope()
  set_maps('n', {
    { '<space>ff', '<cmd>Telescope find_files<CR>', 'Find files' },
    { '<space>fg', '<cmd>Telescope live_grep<CR>', 'Live Grep' },
    { '<space>b', '<cmd>Telescope buffers<CR>', 'Find Buffers' },
    { '<space>h', '<cmd>Telescope help_tags<CR>', 'Help' },
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

return M
