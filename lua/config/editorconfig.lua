local editorconfig = require("editorconfig")

editorconfig.properties.auto_format = function(bufnr, val, _opts)
  local parsed = false
  if val == "true" then
    parsed = true
  elseif val == "false" then
    parsed = false
  else
    -- FIXME: why I can't see this error?
    error(("editorconfig.auto_format can't be %s"):format(val))
    return
  end
  vim.b[bufnr].editorconfig_autoformat = parsed
end
