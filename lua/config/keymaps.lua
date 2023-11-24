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
local nx = { "n", "x" } -- normal, visual
-- local xo = { "x", "o" } -- visual, operator

set(t, "<C-[>", [[<C-\><C-n>]])
set(t, "<esc>", "<esc>")
set(t, "<tab>", "<tab>")

-- detect CTRL-/ in any terimnals
set(nxo, "<c-_>", "<c-/>", { remap = true })

-- fix some default behaviors
set(nx, "K", vim.lsp.buf.hover)

set(nx, "gK", ":Inspect<cr>")

-- paste shortcut for insert mode (paste last yank, not from clipboard)
set(i, "<c-v>", "<c-r>0")

-- command-line remap that feals *right*
set(c, "<c-l>", "<c-d>")

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

-- cycle through command history without arrow keys
-- TODO: only when cmp is not visible
set(c, "<c-n>", "<down>")
set(c, "<c-p>", "<up>")

-- don't move cursor on 'J'
set(n, "J", "mzJ`z")

-- Move lines
-- FIX: do only when 'indentexpr' is not empty
set(x, "J", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move down" })
set(x, "K", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move up" })

-- buffers
set(n, "[b", "<cmd>bprev<cr>", { desc = "Prev buffer" })
set(n, "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
set(n, "<c-p>", "<cmd>tabprev<cr>", { desc = "Prev buffer" })
set(n, "<c-n>", "<cmd>tabnext<cr>", { desc = "Next buffer" })

-- tabs
set(n, "<cs-tab>", "<cmd>tabprev<cr>", { desc = "Prev tab" })
set(n, "<c-tab>", "<cmd>tabnext<cr>", { desc = "Next tab" })

-- quickfix list
set(n, "[q", "<cmd>cprev<cr>", { desc = "Prev qf item" })
set(n, "]q", "<cmd>cnext<cr>", { desc = "Next qf item" })

-- toggle options
-- set(n, "<leader>of", require("lazyvim.plugins.lsp.format").toggle, { desc = "Toggle format on Save" })

-- helix-style mappings
-- stylua: ignore start
set(n, "U", "<C-r>")  -- reasonable redo
set(n, "m", "v")      -- enable mi-/ma- mappings
set(x, "m", "<nop>")  -- =
set(x, "y", "ygv")    -- stay visual mode after yank
set(x, "R", 'P')      -- replace (don't modify registers)
-- stylua: ignore end
set(nxo, "gh", "^", { desc = "goto line start (non-blank)" })
set(nxo, "gl", "g_", { desc = "goto line end (non-blank)" })
set(nxo, "gt", "H")
set(nxo, "gb", "L")
set(nxo, "H", "<nop>") -- disable H/L, try be used to gt/gb
set(nxo, "L", "<nop>")
set(nxo, "%", "gg0vG$")
set(n, "<", "<<")
set(x, "<", "<gv")
set(n, ">", ">>")
set(x, ">", ">gv")
-- TODO: matching using treesitter (or maybe matchup-vim?)
set(nxo, "mm", "%", { desc = "Go to matching" })

set(n, "q", "<cmd>wincmd q<cr>", { desc = "Close window" })
set(n, "Q", "q", { desc = "Record macro" })
