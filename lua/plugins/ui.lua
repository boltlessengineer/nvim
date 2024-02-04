return {
  {
    "levouh/tint.nvim",
    event = "User InitDone",
    -- FIX: doesn't work well with my WinbarNC highlights
    enabled = false,
    opts = {
      tint = -45,
      saturation = 0.6,
      highlight_ignore_patterns = { "LineNr", "Winbar*", "IndentBlankline*" },
    },
  },
  {
    -- TODO: https://github.com/LunarVim/Launch.nvim/blob/0235c4b5f2d44c2e2fe025dc996dd79c68c73c84/lua/user/extras/dressing.lua
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  -- better EOF scrolling
  { "Aasim-A/scrollEOF.nvim", config = true },
  {
    "j-hui/fidget.nvim",
    branch = "legacy",
    event = "LspAttach",
    enabled = true,
    opts = {
      text = {
        spinner = "arc",
      },
      window = {
        relative = "editor",
        blend = 0,
      },
    },
  },
  -- automatic window resizing
  {
    enabled = false,
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    init = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
    end,
    opts = {
      animation = {
        enable = true,
        duration = 150,
      },
    },
  },
  -- smart colorcolumn
  { "m4xshen/smartcolumn.nvim", event = "BufReadPost" },
  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = { char = "▏" },
      whitespace = { remove_blankline_trail = true },
      scope = { enabled = false },
    },
    config = function (_, opts)
      local ibl = require('ibl')
      ibl.setup(opts)
      ibl.overwrite({ exclude = { filetypes = { "norg" } } })
    end,
  },
  -- better list view
  {
    "folke/trouble.nvim",
    enabled = false,
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
      { "<leader>x", desc = "+trouble" },
      { "<leader>xx", cmd = "<cmd>Trouble quickfix<cr>" },
    },
    opts = {
      -- TODO:
      icons = false,
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "qf",
        callback = function(event)
          vim.notify("quickfix!")
          vim.api.nvim_buf_delete(event.buf, {})
          vim.cmd("Trouble quickfix")
        end,
      })
      require("trouble").setup(opts)
    end,
  },
  -- window layout management
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      wo = {
        winbar = false,
      },
      animate = {
        enabled = false,
      },
      bottom = {
        "qf",
      },
    },
  },
  -- better fold
  {
    "kevinhwang91/nvim-ufo",
    event = "BufReadPost",
    dependencies = {
      "kevinhwang91/promise-async",
      {
        "neovim/nvim-lspconfig",
        opts = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
        },
      },
    },
    opts = {
      provider_selector = function(_bufnr, _filetype, _buftype)
        -- use only treesitter for toggleing
        return { "treesitter" }
      end,
    },
    -- stylua: ignore
    keys = {
      { "zR", function() require("ufo").openAllFolds() end },
      { "zM", function() require("ufo").closeAllFolds() end },
    },
    init = function()
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
    end,
  },
  -- alpha
  {
    "goolord/alpha-nvim",
    enabled = false,
    event = "VimEnter",
    arts = {
      [[
███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗
████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ████╗ ████║
██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██╔████╔██║
██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║
██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║
╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝
]],
      [[
           /＾>》, -―‐‐＜＾}
         ./:::/,≠´::::::ヽ.
        /::::〃::::／}::丿ハ
      ./:::::i{l|／　ﾉ／ }::}
     /:::::::瓜イ＞　´＜ ,:ﾉ
   ./::::::|ﾉﾍ.{､　(_ﾌ_ノﾉイ＿
   |:::::::|／}｀ｽ /          /
.  |::::::|(_:::つ/ ThinkPad /　neovim!
.￣￣￣￣￣￣￣＼/＿＿＿＿＿/￣￣￣￣￣
]],
      -- Great ascii arts here:
      -- https://github.com/goolord/alpha-nvim/discussions/16#discussioncomment-2393861
      [[
╭╮╭┬─╮╭─╮┬ ┬┬╭┬╮
│││├┤ │ ││┌╯││││
╯╰╯╰─╯╰─╯╰╯ ┴┴ ┴
]],
      [[
╭╮╭┬─╮╭─╮┬  ┬┬╭┬╮
│││├┤ │ │╰┐┌╯││││
╯╰╯╰─╯╰─╯ ╰╯ ┴┴ ┴
]],
      [[
┌┐┌┬─┐┌─┐┬  ┬┬┌┬┐
│││├┤ │ │└┐┌┘││││
┘└┘└─┘└─┘ └┘ ┴┴ ┴
]],
      [[
╔╗╔╦═╗╔═╗╦  ╦╦╔╦╗
║║║╠╣ ║ ║╚╗╔╝║║║║
╝╚╝╚═╝╚═╝ ╚╝ ╩╩ ╩
]],
    },
    keys = {
      -- FIX: alpha.term doesn't show with this command
      { "<leader>A", "<cmd>Alpha<cr>", desc = "Open dashboard" },
    },
    opts = function(_, dashboard)
      local height = 8
      local padding = 4
      local dynamic_header = {
        type = "terminal",
        command = "cmatrix -u 9",
        width = 60,
        height = height,
        relative = "win",
        opts = {
          position = "center",
          redraw = true,
          window_config = {
            row = padding,
            focusable = false,
          },
        },
      }
      dashboard.section.terminal = dynamic_header
      dashboard.config.layout[1].val = height - 1 + padding
      dashboard.config.layout[2] = dynamic_header
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)
      -- TODO: PR to run this. `alpha.term` should be imported after `alpha`
      -- was imported (to execute terminal type sections)
      require("alpha.term")

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  -- scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      hide_if_all_visible = true,
      marks = {
        Cursor = {
          text = "─",
        },
      },
      excluded_buftypes = {
        "terminal",
        "prompt",
        "nofile",
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
        "alpha",
        "DressingInput",
      },
      handlers = {
        cursor = true,
        diagnostic = false,
        gitsigns = false, -- Requires gitsigns
        handle = true,
        search = false, -- Requires hlslens
      },
    },
  },
  -- smooth scroll
  {
    "declancm/cinnamon.nvim",
    event = "VeryLazy",
    enabled = false,
  },
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    enabled = false,
  },
}
