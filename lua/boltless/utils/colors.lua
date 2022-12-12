-- copied some useful functions from catppuccin/nvim

local M = {}

---@param hex_str string hexadecimal value of a color
local hex_to_rgb = function(hex_str)
  local hex = "[abcdef0-9][abcdef0-9]"
  local pat = "^#(" .. hex .. ")(" .. hex .. ")(" .. hex .. ")$"
  hex_str = string.lower(hex_str)

  assert(string.find(hex_str, pat) ~= nil, "hex_to_rgb: invalid hex_str: " .. tostring(hex_str))

  local red, green, blue = string.match(hex_str, pat)
  return { tonumber(red, 16), tonumber(green, 16), tonumber(blue, 16) }
end

---convert decimal color to rgb table
---@param dec number
local dec_to_rgb = function(dec)
  local b = dec % 256
  dec = (dec - b) / 256;
  local g = dec % 256
  dec = (dec - g) / 256;
  local r = dec % 256
  return { r, g, b }
end

---convert dec or hex style color to rgb table
---@param num number|string
local num_to_rgb = function(num)
  if type(num) == "number" then
    return dec_to_rgb(num)
  else
    return hex_to_rgb(num)
  end
end

---@param fg string|number forecrust color
---@param bg string|number background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function M.blend(fg, bg, alpha)
  local foreground = num_to_rgb(fg)
  local background = num_to_rgb(bg)

  local blendChannel = function(i)
    local ret = (alpha * foreground[i] + ((1 - alpha) * background[i]))
    return math.floor(math.min(math.max(0, ret), 255) + 0.5)
  end

  return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

return M
