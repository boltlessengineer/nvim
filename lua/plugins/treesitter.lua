return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "arduino",
        "astro",
        "bash",
        "c",
        "c_sharp",
        "cmake",
        -- 'comment',
        "cpp",
        "css",
        "dart",
        "diff",
        "dockerfile",
        "fish",
        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
        "go",
        "gomod",
        "gosum",
        "graphql",
        "help",
        "html",
        "http",
        "java",
        "javascript",
        "jsdoc",
        "json",
        "jsonc",
        "kotlin",
        "latex",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "meson",
        "ninja",
        "nix",
        "norg",
        "org",
        "prisma",
        "pug",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "scheme",
        "scss",
        "sql",
        "svelte",
        "swift",
        "teal",
        "toml",
        "tsx",
        "typescript",
        "vhs",
        "vim",
        "vue",
        "yaml",
        "zig",
      })
      opts.playground = {
        enable = true,
      }
    end,
  },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPre",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
      trim_scope = "inner", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      min_window_height = 20, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      patterns = {
        lua = {
          "table_constructor",
        },
      },
      zindex = 20, -- The Z-index of the context window
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
    },
  },
}
