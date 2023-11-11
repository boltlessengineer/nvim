vim.fs.joinpath = vim.fs.joinpath or function(...)
  return table.concat({ ... }, "/")
end

local Util = require("utils")
Util.format.setup()
Util.root.setup()
require("config.options")
require("config.keymaps")
require("config.abbrevs")
require("config.autocmds")
require("config.lazy")
require("config.ui.statusline")
require("config.ui.winbar")

-- for tint.nvim
vim.api.nvim_exec_autocmds("User", { pattern = "InitDone" })
