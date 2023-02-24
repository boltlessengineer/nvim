return {
  {
    "rebelot/heirline.nvim",
    event = "VeryLazy",
    dependencies = {
      "neovim/nvim-lspconfig",
      "lewis6991/gitsigns.nvim",
    },
    config = function()
      require("heirline").setup({
        statusline = require("plugins.heirline.statusline"),
        winbar = require("plugins.heirline.winbar"),
        tabline = require("plugins.heirline.tabline"),
      })
      -- clear default autocmd for winbar
      vim.api.nvim_create_augroup("Heirline_init_winbar", { clear = true })
      -- set winbar globally
      vim.o.winbar = "%{%v:lua.require'heirline'.eval_winbar()%}"
      -- more autocmds to work properly
      local aug = vim.api.nvim_create_augroup("heirline_stuffs", { clear = true })
      local load_colors = require("plugins.heirline.colors").load_colors
      load_colors()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = aug,
        callback = load_colors,
      })
      vim.api.nvim_create_autocmd("ModeChanged", {
        group = aug,
        pattern = "*:*o",
        command = "redrawstatus",
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = aug,
        command = "redrawtabline",
      })
    end,
  },
}
