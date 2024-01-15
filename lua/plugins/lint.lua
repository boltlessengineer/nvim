return {
  "mfussenegger/nvim-lint",
  enabled = false,
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    linters_by_ft = {
      javascript = { "eslint_d" },
      ["javascript.jsx"] = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      -- lua = { "luacheck" },
      -- rst = { "rstlint" },
      -- sh = { "shellcheck" },
      typescript = { "eslint_d" },
      ["typescript.tsx"] = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      -- vim = { "vint" },
      -- yaml = { "yamllint" },
    }
  },
  config = function (_, opts)
    local lint = require('lint')
    local Util = require('utils')
    local M = {}
    lint.linters_by_ft = opts.linters_by_ft
    function M.lint()
      local names = lint._resolve_linter_by_ft(vim.bo.filetype)
      -- TODO: filter
      if #names > 0 then
        lint.try_lint(names)
      end
    end
    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = Util.debounce(100, M.lint)
    })
  end
}
