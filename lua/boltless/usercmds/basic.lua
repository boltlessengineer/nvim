local function usercmd(name, command, opts)
  vim.api.nvim_create_user_command(name, command, opts)
end

usercmd('ToggleNums', function()
  if vim.go.number then
    vim.notify('nonumber')
    vim.o.number = false
    vim.o.relativenumber = false
    vim.o.signcolumn = 'no'
  else
    vim.notify('number')
    vim.o.number = true
    vim.o.relativenumber = true
    vim.o.signcolumn = 'yes'
  end
end, { desc = 'Toggle numberlines & signcolumn' })
