-- Global functions
P = function(v)
  print(vim.inspect(v))
  return v
end

vim.g.borderstyle = 'rounded' -- NOTE: `:h api-floatwin`
vim.g.diminable = false
