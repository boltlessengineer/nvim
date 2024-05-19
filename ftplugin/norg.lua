-- TODO: maybe simple vim file is enough
-- vim.opt_local.conceallevel = 2
vim.opt_local.formatoptions:remove('r')

vim.cmd[[
nnoremap <buffer> j gj
nnoremap <buffer> k gk
nnoremap <buffer> 0 g0
nnoremap <buffer> ^ g^
nnoremap <buffer> $ g$

setlocal breakindent
setlocal linebreak
setlocal wrap
setlocal shiftwidth=1
]]
