local ok, indent = pcall(require, 'indent_blankline')
if not ok then return end

indent.setup {
  -- Hide indent-blankline if tap-width is 2
  -- char = (vim.opt.shiftwidth:get() == 4) and '▏' or '',
  char = '▏',
}
