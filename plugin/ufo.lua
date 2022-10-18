local ok, ufo = pcall(require, 'ufo')
if not ok then return end

-- TODO: replace nvim-ufo with native treesitter folding
-- NOTE: https://www.jmaguire.tech/posts/treesitter_folding/
-- TODO: show fold-icons right next to functions/tags (like source-view in web browser)

-- TODO: set these options ONLY if treesitter enabled, set foldcolumn='1'
-- TODO: set foldcolumn=1 when neovim#17446 is merged (see also nvim-ufo#4)
-- window local, default '0'
vim.o.foldcolumn = '0'
-- window local, default 0
vim.o.foldlevel = 99
-- window local, default -1
vim.o.foldlevelstart = 99

vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

ufo.setup {
  open_fold_hl_timeout = 0,
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end
}
