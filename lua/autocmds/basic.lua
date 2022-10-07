vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = 'yes:1'
    -- Use toggleterm.nvim with option below
    vim.opt_local.winfixheight = true
  end
})
-- TODO: hide save message & notify with nvim-notify
--       https://stackoverflow.com/q/18396759/13150270

-- TODO: smart hybrid number line
--       https://jeffkreeftmeijer.com/vim-number/
