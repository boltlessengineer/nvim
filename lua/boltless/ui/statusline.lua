-- NOTE: workspace-diagnostics
-- https://www.reddit.com/r/neovim/comments/vlp14v/is_there_any_plugin_that_shows_all_diagnostics/

-- vim.o.statusline = '%#STNormalA# NORMAL %#STNormalB# main [!?*] %#StatusLine# E:0 W:0%=%Y UTF-8 18:25'
-- vim.o.statusline = '%#STNormal#[NORMAL]%#STNormalB# main %#DiagnosticSignError# E-3 %#DiagnosticSignWarn#W-12%#StatusLine#%=%Y  UTF-8  18:25 '
vim.o.statusline = '%#STNormal# NORMAL %#StatusLine# main (E-3 W-12)%=%Y  UTF-8  18:25 '

--[[




lua/boltless/ui/statusline.lua 1 [+]                                                      35%
l/b/u/statusline.lua 1 [+]                                                                35%




l/b/u/statusline.lua 1 [+]        [17,35]  Bot l/b/u/statusline.lua 1 [+]                    
Food Truck > App > Truck > TruckView > body    Food Truck > App > Truck > TruckView > body                                                                   
 _   2 print()                                  _   2 print()                                                                   
 |   1 -- TODO: adfafdsasf                      |   1 -- TODO: adfafdsasf                                                                   
 | 3   vim.fn.jobstart({                        | 3   vim.fn.jobstart({                                                                   
 ~   1   cmd = {                                ~   1   cmd = {                                                                   
.    2     'git',                                   2     'git',       
[NORMAL] feature:master [+!?]                                E:0 W:0       LUA UTF-8 18:25
^ mode   ^ git                                               ^ diagnostics ^   ^ format     
.                                                                          | Treesitter



]]
-- IDEA: highlight 'LUA' when treesitter enabled
