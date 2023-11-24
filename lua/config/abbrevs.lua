vim.cmd.cabbrev("neogit", "Neogit")
vim.cmd.cabbrev("git", "Neogit")
-- just in case... I forgot `g/` binding too often
vim.cmd.cabbrev("comment", "normal g/")

-- quick chmod +x
vim.cmd.cabbrev("chmod", "!chmod +x %")

-- auto correct typo on command line
vim.cmd.cabbrev("w'", "w")
vim.cmd.cabbrev("ems", "mes")

vim.cmd.cabbrev("ㅈ", "w")
-- Not abbrev, but put these here because these are about typo-stuffs
local function set(lhs, rhs)
  vim.keymap.set({ "n", "x", "o" }, lhs, rhs, { remap = true })
end
set("ㅂ", "q")
set("ㅈ", "w")
set("ㄷ", "e")
set("ㄱ", "r")
set("ㅅ", "t")
set("ㅛ", "y")
set("ㅕ", "u")
set("ㅑ", "i")
set("ㅐ", "o")
set("ㅔ", "p")
set("ㅁ", "a")
set("ㄴ", "s")
set("ㅇ", "d")
set("ㄹ", "f")
set("ㅎ", "g")
set("ㅗ", "h")
set("ㅓ", "j")
set("ㅏ", "k")
set("ㅣ", "l")
set("ㅋ", "z")
set("ㅌ", "x")
set("ㅊ", "c")
set("ㅍ", "v")
set("ㅠ", "b")
set("ㅜ", "n")
set("ㅡ", "m")
