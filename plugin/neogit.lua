local ok, neogit = pcall(require, 'neogit')
if not ok then return end

-- TODO: setup neogit
neogit.setup {}

require('keymaps.external').neogit()
