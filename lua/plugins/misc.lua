return {
  -- makes some plugins dot-repeatable like leap
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "johngrib/vim-f-hangul", keys = { "f", "t", "F", "T", ";", "," } },
  "lambdalisue/suda.vim",
  {
    "wintermute-cell/gitignore.nvim",
    cmd = "Gitignore",
    keys = {
      { "<leader>gi", "<cmd>Gitignore<cr>", desc = "Generate gitignore" },
    },
    dependencies = "nvim-telescope/telescope.nvim",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function () vim.fn["mkdp#util#install"]() end,
    init = function ()
      vim.g.mkdp_port = "8000"
    end,
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
  {
    "brenoprata10/nvim-highlight-colors",
    event = "BufReadPre",
    opts = {
      render = "virtual",
      enable_named_colors = true,
      enable_tailwind = true,
    }
  },
  -- show status in discord
  {
    "andweeb/presence.nvim",
    enabled = false,
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
    enabled = false,
    cmd = { "PetsNew", "PetsNewCustom" },
    dependencies = { "edluffy/hologram.nvim", "MunifTanjim/nui.nvim" },
    config = true,
  },
  -- measure startuptime
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  -- cool neovim startup profile with GUI
  { "stevearc/profile.nvim", enabled = false },
  {
    "ThePrimeagen/lsp-debug-tools.nvim",
    lazy = true,
  },
}
