local ok, surround = pcall(require, 'nvim-surround')
if not ok then return end

-- TODO: replace keymaps based on vim-sandwich
surround.setup({
  keymaps = {
    insert = '<C-g>s',
    insert_line = '<C-g>S',
    normal = 'ys',
    normal_cur = 'yss',
    normal_line = 'yS',
    normal_cur_line = 'ySS',
    visual = 'S',
    visual_line = 'gS',
    delete = 'ds',
    change = 'cs',
  },
})
