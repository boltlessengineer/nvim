local M = {}
-- TODO: show only full path in NC, show navic when focused
-- TODO: nvim-navic feature) conceal item text when cursor goes too deeper

function M.get_no_plugin()
  return [[ %{expand('%f') != '' ? pathshorten(fnamemodify(expand('%f'), ':.')) : '[No Name]'} ]]
      .. [[%m%h%w%r%=%<%-8.([%l,%c]%) %P ]]
end

return M
