require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
require("config.ui.statusline")
require("config.ui.winbar")

-- for tint.nvim
vim.api.nvim_exec_autocmds("User", { pattern = "InitDone" })
