-- Keysets are automatically loaded on the VeryLazy event
-- Default keysets that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keysets.lua
-- Add any additional keysets here

local set = vim.keymap.set

local n = "n" -- normal
-- local v = "v" -- visual/select
local x = "x" -- visual
-- local s = "s" -- select
-- local o = "o" -- operator
local i = "i" -- insert
local c = "c" -- command
local t = "t" -- terminal

local nxo = { "n", "x", "o" } -- normal, visual, operator (for motion mappings)
-- local xo = { "x", "o" } -- visual, operator

set(t, "<C-[>", [[<C-\><C-n>]])

-- better up/down
set(n, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
set(n, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
set(
  n,
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set(nxo, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
set(nxo, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
set(i, ",", ",<c-g>u")
set(i, ".", ".<c-g>u")
set(i, ";", ";<c-g>u")

-- Lazy
set(n, "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- don't yank on paste
set(x, "p", '"_dP')

-- cycle through command history without arrow keys
set(c, "<c-n>", "<down>")
set(c, "<c-p>", "<up>")

-- Move lines
set(x, "J", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move down" })
set(x, "K", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move up" })

-- buffers
set(n, "[b", "<cmd>bprev<cr>", { desc = "Prev buffer" })
set(n, "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
set(n, "<c-p>", "<cmd>bprev<cr>", { desc = "Prev buffer" })
set(n, "<c-n>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- tabs
set(n, "<cs-tab>", "<cmd>tabprev<cr>", { desc = "Prev tab" })
set(n, "<c-tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- save file
set("", "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- toggle options
set(n, "<leader>of", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })

-- helix-style mappings
-- stylua: ignore start
set(n, "U", "<C-r>")  -- reasonable redo
set(x, "y", "ygv")    -- stay visual mode after yank
set(x, "p", "<esc>p") -- paste after
set(x, "P", "<esc>P") -- paste before
set(x, "R", "p")      -- paste
-- stylua: ignore end
set(nxo, "gh", "^")
set(nxo, "gl", "$")
set(nxo, "gt", "H")
set(nxo, "gb", "L")
set(nxo, "%", "gg0vG$")
set(n, "<", "<<")
set(x, "<", "<gv")
set(n, ">", ">>")
set(x, ">", ">gv")
-- TODO: more helix style mappings
-- o   - im : closest surround pair
set(nxo, "m", "<nop>")
-- TODO: matching using treesitter (or maybe matchup-vim?)
set(nxo, "mm", "%", { desc = "Go to matching" })

set(n, "q", "<cmd>close<cr>", { desc = "Close window" })
set(n, "Q", "q", { desc = "Record macro" })
