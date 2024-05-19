-- FIXME: this breaks cabbrev... cabrev doesn't works with this keymap
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

-- TODO: iabbrev retrun -> return
