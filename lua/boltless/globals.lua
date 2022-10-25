-- Global functions
P = function(v)
  print(vim.inspect(v))
  return v
end

vim.g.borderstyle = 'none' -- NOTE: `:h api-floatwin`
vim.g.diminable = false
