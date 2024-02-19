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
require("config.editorconfig")
require("config.lazy")
-- setup colorscheme
-- pcall require here to lazy-load colorscheme
pcall(require, "kanagawa")
vim.cmd.colorscheme("kanagawa-dragon")
require("config.ui")
require("config.ui.statusline")
require("config.ui.winbar")

-- for tint.nvim
vim.api.nvim_exec_autocmds("User", { pattern = "InitDone" })

vim.opt.rtp:prepend(vim.fs.normalize("$HOME/projects/tree-sitter-norg3"))
if not vim.treesitter.language.get_lang("norg") then
    vim.treesitter.language.add("norg", { path = vim.fs.normalize("$HOME/.cache/tree-sitter/lib/norg.so") })
    vim.treesitter.language.register("norg", "norg")
end
-- rainbow heading
vim.cmd[[
hi link @markup.heading.1.norg @attribute
hi link @markup.heading.2.norg @label
hi link @markup.heading.3.norg @constant
hi link @markup.heading.4.norg @string
hi link @markup.heading.5.norg @label
hi link @markup.heading.6.norg @constructor
hi link @markup.heading.1.marker.norg @attribute
hi link @markup.heading.2.marker.norg @label
hi link @markup.heading.3.marker.norg @constant
hi link @markup.heading.4.marker.norg @string
hi link @markup.heading.5.marker.norg @label
hi link @markup.heading.6.marker.norg @constructor
]]
