if not pcall(require, 'heirline') then
  return
end

require('plugins.heirline')

-- TODO:
-- boltless/ui/statusline.lua : basic lua-based statusline, not loaded if heirline exists
-- boltless/ui/winbar.lua : same as statusline
--
-- boltless/plugin/heirline/init.lua: setup statusline/winbar/tabline using heirline (fallback to aboves)
-- boltless/plugin/heirline/components.lua : heirline components
