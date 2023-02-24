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

-- Set options for terminal buffer
-- Use `BufWinEnter term://*` instead of just `TermOpen`
-- just `TermOpen` isn't enough when terminal buffer is created in background
au({ "TermOpen", "BufWinEnter" }, {
  group = aug("terminal_local_options"),
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
