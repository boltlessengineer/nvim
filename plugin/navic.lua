local ok, navic = pcall(require, 'nvim-navic')
if not ok then return end

navic.setup {
  highlight = true,
}
