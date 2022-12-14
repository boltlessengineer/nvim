local ok, netrw = pcall(require, 'netrw')
if not ok then return end

netrw.setup {
  mappings = {
    ['p'] = function (payload)
      vim.pretty_print(payload)
    end,
  },
}
