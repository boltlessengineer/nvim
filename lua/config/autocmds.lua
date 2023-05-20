-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local aug = function(group_name, clear)
  clear = vim.F.if_nil(clear, true)
  return vim.api.nvim_create_augroup(group_name, { clear = clear })
end

local au = vim.api.nvim_create_autocmd

-- disable default autocmds
aug("lazyvim_close_with_q") -- enabled globally
aug("lazyvim_wrap_spell") -- don't want spell

au({ "FocusGained", "TermClose", "TermLeave" }, {
  group = aug("checktime"),
  command = "checktime",
})

-- Highlight on yank
au("TextYankPost", {
  group = aug("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Resize splits if window got resized
au("VimResized", {
  group = aug("resize_splits"),
  command = "tabdo wincmd =",
})

-- Go to last location when opening a buffer
au("BufReadPost", {
  group = aug("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exists
au("BufWritePre", {
  group = aug("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Set options for terminal buffer
-- Use `BufWinEnter term://*` instead of just `TermOpen`
-- just `TermOpen` isn't enough when terminal buffer is created in background
au({ "TermOpen", "BufWinEnter" }, {
  group = aug("terminal_options"),
  pattern = "term://*",
  callback = function()
    -- I should use `setlocal` than `vim.wo` or `vim.bo`
    -- vim.wo[winid] only works with specific window id
    vim.cmd([[
      setlocal nonu
      setlocal nornu
      setlocal nolist
      setlocal signcolumn=no
      setlocal foldcolumn=0
      setlocal statuscolumn=
      setlocal nocursorline
      setlocal scrolloff=0
    ]])
  end,
})

local ftplugins = aug("ftplugins")

au("FileType", {
  group = ftplugins,
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.conceallevel = 0
  end,
})

-- HACK: umm... is this right way..?
au("BufWinEnter", {
  group = ftplugins,
  pattern = "NeogitStatus",
  callback = function()
    vim.wo.foldcolumn = "0"
    vim.wo.statuscolumn = ""
  end,
})
