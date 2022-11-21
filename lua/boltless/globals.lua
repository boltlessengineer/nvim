-- Global functions
P = function(v)
  print(vim.inspect(v))
  return v
end

-- Shortcut to vim.notify(DEBUG)
vim.debug = function(msg, opts)
  vim.notify(msg, vim.log.levels.DEBUG, opts)
end
-- Shortcut to vim.notify(INFO)
vim.info = function(msg, opts)
  vim.notify(msg, vim.log.levels.INFO, opts)
end
-- Shortcut to vim.notify(WARN)
vim.warn = function(msg, opts)
  vim.notify(msg, vim.log.levels.WARN, opts)
end
-- Shortcut to vim.notify(ERROR)
vim.error = function(msg, opts)
  vim.notify(msg, vim.log.levels.ERROR, opts)
end

vim.g.borderstyle = 'rounded' -- NOTE: `:h api-floatwin`
vim.g.diminable = false
vim.g.autoformat = false
