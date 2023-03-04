return {
  -- automatic window resizing
  {
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
  "m4xshen/smartcolumn.nvim",
  -- indent
  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = "▏",
      context_char = "▏",
      show_current_context = true,
      show_current_context_start = true,
      context_start_priority = 50, -- set this low to not cover diagnostic underlines
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
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("   %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
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
    -- TODO: temporary disable (maybe forever?)
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
    dependencies = {
      -- 'kevinhwang91/nvim-hlslens',
      -- 'lewis6991/gitsigns.nvim',
    },
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
      },
      excluded_filetypes = {
        "prompt",
        "TelescopePrompt",
        "noice",
        "notify",
        "alpha",
        "DressingInput",
        -- "neo-tree",
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
