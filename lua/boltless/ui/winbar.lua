local M = {}

vim.o.winbar = [[%{%v:lua.require('boltless.ui.winbar').generate()%}]]

function M.generate()
  return [[%#WinBarTitle# %t %h%w%m%r%#WinBar#%=%<%-8.([%l,%c]%) %P ]]
  -- return [[ %f %h%w%m%r%=%<%-8.([%l,%c]%) %P ]]
end

return M
