return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
    init = function(plugin)
      -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
      -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
      -- no longer trigger the **nvim-treeitter** module to be loaded in time.
      -- Luckily, the only thins that those plugins need are the custom queries, which we make available
      -- during startup.
      require("lazy.core.loader").add_to_rtp(plugin)
      require("nvim-treesitter.query_predicates")
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
          enable = true,
          max_lines = 3,
          trim_scope = "inner",
          min_window_height = 20,
          patterns = {
            lua = {
              "table_constructor",
            },
          },
          zindex = 20,
          mode = "cursor",
        },
      },
    },
    main = "nvim-treesitter.configs",
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      ensure_installed = {
        -- "arduino",
        -- "astro",
        "bash",
        -- "c",
        -- "c_sharp",
        -- "cmake",
        -- "cpp",
        -- "css",
        -- "dart",
        -- "diff",
        -- "dockerfile",
        -- "fish",
        -- "git_rebase",
        -- "gitattributes",
        -- "gitcommit",
        -- "gitignore",
        -- "go",
        -- "gomod",
        -- "gosum",
        -- "graphql",
        -- "html",
        -- "http",
        -- "java",
        -- "javascript",
        -- "jsdoc",
        -- "json",
        -- "jsonc",
        -- "kotlin",
        -- "latex",
        "lua",
        -- "make",
        "markdown",
        "markdown_inline",
        -- "meson",
        -- "ninja",
        -- "nix",
        -- "org",
        -- "prisma",
        -- "pug",
        -- "python",
        "query",
        "regex",
        -- "ruby",
        -- "rust",
        "scheme",
        -- "scss",
        -- "sql",
        -- "svelte",
        -- "swift",
        -- "teal",
        -- "toml",
        -- "tsx",
        -- "typescript",
        -- "vhs",
        "vim",
        "vimdoc",
        -- "vue",
        -- "yaml",
        -- "zig",
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
      playground = { enable = true },
      incremental_selection = {
        enable = false,
        keymaps = {
          node_incremental = "v",
          -- FIXME: can't use `V` here, it will block entering Visual-line mode
          node_decremental = "V",
        },
      },
    },
  },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },
}
