return {
  "echasnovski/mini.ai",
  keys = {
    { "a", mode = { "x", "o" } },
    { "i", mode = { "x", "o" } },
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    init = function()
      -- PERF: no need to load the plugin because we only need its queries for mini.ai
      require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
    end,
  },
  opts = function()
    local ai = require("mini.ai")
    local ts_gen = ai.gen_spec.treesitter
    return {
      n_lines = 500,
      custom_textobjects = {
        -- flip balanced / unbalanced mappings
        ["("] = { "%b()", "^.().*().$" },
        [")"] = { "%b()", "^.%s*().-()%s*.$" },
        ["["] = { "%b[]", "^.().*().$" },
        ["]"] = { "%b[]", "^.%s*().-()%s*.$" },
        ["{"] = { "%b{}", "^.().*().$" },
        ["}"] = { "%b{}", "^.%s*().-()%s*.$" },
        ["<"] = { "%b<>", "^.().*().$" },
        [">"] = { "%b<>", "^.%s*().-()%s*.$" },
        -- TODO: support im, am for any kinds of closest match

        -- remove unused default mappings
        ["?"] = false,
        -- custom mappings
        ["f"] = ts_gen({ a = "@function.outer", i = "@function.inner" }),
        ["c"] = ts_gen({ a = "@class.outer", i = "@class.inner" }),
        ["C"] = ts_gen({ a = "@comment.outer", i = "@comment.inner" }),
      },
      silent = false,
    }
  end,
}
