local refactoring = require("utils").reqidx("refactoring")

return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<leader>r", function() refactoring.select_refactor() end, mode = { "v" }, desc = "Refactor" },
      { "<leader>rp", function() refactoring.debug.printf({ below = true }) end, desc = "Printf" },
      { "<leader>rv", function() refactoring.debug.print_var({ normal = true }) end, desc = "Print Var" },
      { "<leader>rc", function() refactoring.debug.cleanup({}) end, desc = "Cleanup" },
    },
    opts = {
      prompt_func_return_type = {},
      prompt_func_param_type = {},
      printf_statements = {},
      print_var_statements = {},
      extract_var_statements = {},
    },
  },
}
