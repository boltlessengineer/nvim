local Util = require("utils")

local ext_telescope = Util.require.on_exported_call("sg.extensions.telescope")

return {
  {
    "sourcegraph/sg.nvim",
    -- TODO: how to lazy-load sg.nvim?
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    -- keys = { "<leader>ss", ext_telescope.fuzzy_search_results },
    opts = {
      -- enable_cody = false,
      on_attach = function (_, bufnr)
        local nx = { 'n', 'x' }
        vim.keymap.set(nx, 'gd', vim.lsp.buf.definition, { buffer = bufnr })
        vim.keymap.set(nx, 'gy', vim.lsp.buf.type_definition, { buffer = bufnr })
        vim.keymap.set(nx, 'gr', vim.lsp.buf.references, { buffer = bufnr })
        vim.keymap.set(nx, 'gI', vim.lsp.buf.implementation, { buffer = bufnr })
        vim.keymap.set(nx, 'gD', vim.lsp.buf.declaration, { buffer = bufnr })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
      end
    }
  }
}
