return {
  -- set buffer options automatically based on file contents
  -- TODO: guess-indent.nvim for similar feature?
  { "tpope/vim-sleuth", event = "VeryLazy" },
  { "johngrib/vim-f-hangul", keys = { "f", "t", "F", "T", ";", "," } },
  {
    "wintermute-cell/gitignore.nvim",
    cmd = "Gitignore",
    keys = {
      { "<leader>gi", "<cmd>Gitignore<cr>", desc = "Generate gitignore" },
    },
    dependencies = "nvim-telescope/telescope.nvim",
  },
  {
    "dimaportenko/telescope-simulators.nvim",
    -- FIX: can't lazyload with sub-command `Telescope simulators run`
    enabled = false,
    main = "simulators",
    opts = {
      android_emulator = false,
      apple_simulator = true,
    },
  },
  -- colorizer
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      filetypes = { "*", "!lazy" },
      buftypes = { "*", "!prompt", "!nofile" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = false, -- "Name" codes like Blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = false, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        virtualtext = "■",
      },
    },
  },
  -- show status in discord
  {
    "andweeb/presence.nvim",
    event = "VeryLazy",
    config = function()
      -- local presence = require("presence")
      -- local augroup = vim.api.nvim_create_augroup("discord_connect", { clear = true })
      -- FIX: autocmds here doesn't work for now
      --
      -- vim.api.nvim_create_autocmd({
      --   "FocusLost",
      -- }, {
      --   group = augroup,
      --   callback = function()
      --     presence.is_authorized = false
      --     presence.is_authorizing = false
      --     presence.is_connected = false
      --     presence.is_connecting = false
      --     presence:stop()
      --   end,
      -- })
      -- vim.api.nvim_create_autocmd({
      --   "FocusGained",
      -- }, {
      --   group = augroup,
      --   callback = function()
      --     presence:update()
      --   end,
      -- })
    end,
  },
  {
    "giusgad/pets.nvim",
    cmd = { "PetsNew", "PetsNewCustom" },
    dependencies = { "edluffy/hologram.nvim", "MunifTanjim/nui.nvim" },
    config = true,
  },
}
