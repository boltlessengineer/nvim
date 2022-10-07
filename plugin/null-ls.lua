local ok, null_ls = pcall(require, 'null-ls')
if not ok then return end

null_ls.setup()
