local ok, neoconf = pcall(require, 'neoconf')
if not ok then return end

neoconf.setup {
  import = {
    vscode = true, -- local .vscode/settings.json
  },
}
