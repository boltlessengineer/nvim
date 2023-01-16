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
function M.lsp(buffer)
  local opts = { buffer = buffer }
  set_maps('n', {
    -- actions
    { '<space>lr', vim.lsp.buf.rename, 'Rename' },
    { '<space>la', vim.lsp.buf.code_action, 'Code Action' },
    { '<space>lfr', vim.lsp.buf.format, 'Format File' },
    { '<space>lfm', '<cmd>FormatModifications<CR>', 'Format Modifications' },
    { 'K', vim.lsp.buf.hover, 'Hover Document' },
    -- goto+
    { 'gd', vim.lsp.buf.definition, 'Go to Definition' },
    { 'gt', vim.lsp.buf.type_definition, 'Go to Type Definition' },
    { 'ge', vim.lsp.buf.references, 'References' },
    -- next/prev
    { '[d', vim.diagnostic.goto_prev, 'Prev Diagnostic' },
    { ']d', vim.diagnostic.goto_next, 'Next Diagnostic' },
    { '[e', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, 'Prev Error' },
    { ']e', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, 'Next Error' },
    { '[w', function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, 'Prev Warning' },
    { ']w', function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, 'Next Warning' },
    -- TODO: <space>lm for LSP menu (turn on/off AutoFormat, etc)
  }, opts)
  -- HACK: update LSP keymaps when trouble enabled
  local ok = pcall(require, 'trouble')
  if ok then
    set_maps('n', {
      { 'gd', '<cmd>Trouble lsp_definitions<CR>', 'Go to definition' },
      { 'ge', '<cmd>Trouble lsp_references<CR>', 'References' },
    }, opts)
  end
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
    -- TODO: replace `help_tags` with custom floating-help Telescope command
    -- just running `help ~` on floating window can make floating help window
    -- floating-help-window should be replaced with new help buffer
    { '<F1>', '<cmd>Telescope help_tags<CR>', 'Help' },
    { '<space>e', '<cmd>Telescope file_browser<CR>', 'File Browser' },
  })
end

-- NvimTree
function M.nvimtree()
  set_maps('n', {
    -- { '<C-e>', '<cmd>NvimTreeToggle<CR>', 'FileTree' },
  })
end

-- Comments
function M.comment()
  local api = require('Comment.api')
  set_maps('n', {
    { 'g/', api.toggle.linewise.current, 'Comment Linewise' },
    { [[<C-/>]], api.toggle.linewise.current, 'Comment Linewise' },
    { [[<C-\>]], api.toggle.blockwise.current, 'Comment Blockwise' },
  })
  set_maps('v', {
    { 'g/', '<Plug>(comment_toggle_linewise_visual)', 'Comment Linewise' },
    { [[<C-/>]], '<Plug>(comment_toggle_linewise_visual)', 'Comment Linewise' },
    { [[<C-\>]], '<Plug>(comment_toggle_blockwise_visual)', 'Comment Blockwise' },
  })
end

-- Git
function M.git(buffer)
  set_maps('n', {
    { '[g', '<cmd>Gitsigns prev_hunk<CR>', 'Prev Hunk' },
    { ']g', '<cmd>Gitsigns next_hunk<CR>', 'Next Hunk' },
  }, { buffer = buffer })
end

-- Neogit
function M.neogit()
  set_maps('n', {
  })
end

-- Neovide
function M.neovide()
  set_maps('n', {
    { '<C-Tab>', '<cmd>tabnext<CR>', 'Next tab' },
    { '<CS-Tab>', '<cmd>tabprev<CR>', 'Prev tab' },
  })
end

return M
