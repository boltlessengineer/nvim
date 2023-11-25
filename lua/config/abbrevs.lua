local Aliases = {}
-- NOTE: don't use <tab> here. it messes up with wildchar (see `:h 'wildchar'`)
local trigger_chars = { "<space>", "<cr>" }
for _, char in ipairs(trigger_chars) do
  vim.keymap.set("c", char, function()
    if vim.fn.getcmdtype() == ":" then
      local rhs = Aliases[vim.fn.getcmdline()]
      if rhs then
        vim.fn.setcmdline(rhs)
      end
    end
    return char
  end, { expr = true })
end

---make alias in command line
---this method can detect current cmdtype and only execute on exact match
---while `cabbrev` works on every cmdtype and can execute on mid-line
---@param lhs string
---@param rhs string
local function calias(lhs, rhs)
  Aliases[lhs] = rhs
end

calias("neogit", "Neogit")
calias("git", "Neogit")
-- just in case... I forgot `g/` binding too often
calias("'<,'>comment", "'<,'>normal g/")
calias("comment", "normal g/")

-- quick chmod +x
calias("chmod", "!chmod +x %")

-- auto correct typo on command line
calias("w'", "w")
calias("ems", "mes")

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
