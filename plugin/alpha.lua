local ok, alpha = pcall(require, 'alpha')
if not ok then return end

local db = require('alpha.themes.dashboard')
-- local sf = require('alpha.themes.startify')

-- NOTE: [idea] print small matrix screen here
local image = {
  [[
███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]] ,
  [[
           /＾>》, -―‐‐＜＾}
         ./:::/,≠´::::::ヽ.
        /::::〃::::／}::丿ハ
      ./:::::i{l|／　ﾉ／ }::}
     /:::::::瓜イ＞　´＜ ,:ﾉ
   ./::::::|ﾉﾍ.{､　(_ﾌ_ノﾉイ＿
   |:::::::|／}｀ｽ /          /
.  |::::::|(_:::つ/ ThinkPad /　neovim!
.￣￣￣￣￣￣￣＼/＿＿＿＿＿/￣￣￣￣￣
]] ,
  -- Great ascii arts here: https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-2393861
  [[
╭╮╭┬─╮╭─╮┬ ┬┬╭┬╮
│││├┤ │ ││┌╯││││
╯╰╯╰─╯╰─╯╰╯ ┴┴ ┴
]] ,
  [[
╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
│││├┤ │ │╰┐┌╯││││
╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
]] ,
  [[
┌┐┌┬─┐┌─┐┬  ┬┬┌┬┐
│││├┤ │ │└┐┌┘││││
┘└┘└─┘└─┘ └┘ ┴┴ ┴
]] ,
  [[
╔╗╔╦═╗╔═╗╦  ╦╦╔╦╗
║║║╠╣ ║ ║╚╗╔╝║║║║
╝╚╝╚═╝╚═╝ ╚╝ ╩╩ ╩
]] ,
}

local image_tbl = {}
for line in image[3]:gmatch('[^\n]+') do
  table.insert(image_tbl, line)
end

db.section.header.val = image_tbl

db.section.buttons.val = {
  db.button('f', '> Find File', ':Telescope find_files<CR>'),
  db.button('r', '> Recent Files', ':Telescope oldfiles<CR>'),
  db.button('t', '> Find Text', ':Telescope live_grep<CR>'),
  db.button('c', '> Configuration', ':cd ~/.config/nvim<bar>e init.lua<CR>'),
  db.button('u', '> Update Plugins', ':PackerSync<CR>'),
  db.button('q', '> Quit', ':qa<CR>'),
}

db.section.footer.val = 'i_dont_have_blog_yet.com'

-- IDEA: just an idea; show isntalled plugins list
-- source: [cruzin/dotfiles](https://codeberg.org/cruzin/dotfiles/src/commit/e3b38b40ca295beed977259236ecb4def505fbac/.config/nvim/lua/user/utils.lua#L18)

alpha.setup(db.opts)

require('autocmds.external').alpha()
