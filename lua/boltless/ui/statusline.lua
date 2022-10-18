local M = {}
-- NOTE: workspace-diagnostics
-- https://www.reddit.com/r/neovim/comments/vlp14v/is_there_any_plugin_that_shows_all_diagnostics/

local original = vim.api.nvim_get_hl_by_name('StatusLine', true)
if original.foreground then
  original.foreground = '#' .. string.format('%06x', original.foreground)
end
if original.background then
  original.background = '#' .. string.format('%06x', original.background)
end
vim.api.nvim_set_hl(0, 'StatusLineTitle', {
  fg = original.foreground,
  bg = original.background,
  bold = true,
})
vim.api.nvim_set_hl(0, 'StatusLine', {
  fg = original.background,
  bg = original.foreground,
})

function M.get_no_plugin()
  return [[%#StatusLineTitle# NoPlugin %#StatusLine# %{getcwd()}%=[%{&fileformat}]%y]]
end

-- vim.o.statusline = [[ NORMAL %#StatusLine#%=%Y  UTF-8  18:25 ]]

-- TODO: recording message
-- https://www.reddit.com/r/neovim/comments/xy0tu1/cmdheight0_recording_macros_message/

-- TODO: example statusline design & configs
-- https://www.reddit.com/r/neovim/comments/xtynan/show_me_your_statusline_big_plus_if_you_wrote_it/

--[[




lua/boltless/ui/statusline.lua 1 [+]                                                      35%
l/b/u/statusline.lua 1 [+]                                                                35%




l/b/u/statusline.lua 1 [+]        [17,35]  Bot l/b/u/statusline.lua 1 [+]                    
Food Truck > App > Truck > TruckView > body   |Food Truck > App > Truck > TruckView > body                                                                   
 _   2 print()                                | _   2 print()                                                                   
 |   1 -- TODO: adfafdsasf                    | |   1 -- TODO: adfafdsasf                                                                   
 | 3   vim.fn.jobstart({                      | | 3   vim.fn.jobstart({                                                                   
 ~   1   cmd = {                              | ~   1   cmd = {                                                                   
.    2     'git',                             |     2     'git',       
[NORMAL] feature:master (+!?) | E:0 W:0                                         lua | utf-8
^ mode   ^ git                  ^ diagnostics                                   ^     ^ format     
.                                                                               Treesitter

[NORMAL] master (!) | E:0 W:0                                         spaces: 2 | lua | utf-8 
4 12, 6 3, 1 3


]]
-- IDEA: highlight 'LUA' when treesitter enabled
return M
