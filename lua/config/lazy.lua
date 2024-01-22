local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- library used by other plugins
    { "nvim-lua/plenary.nvim", lazy = true },
    { import = "plugins" },
    -- { import = "plugins.extras.lang.rust" },
    -- { import = "plugins.extras.lang.flutter" },
  },
  ---@diagnostic disable-next-line: assign-type-mismatch
  dev = {
    path = vim.fn.has('mac') and "~/Projects" or "~/projects",
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "kanagawa" } },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = false,
  },
  change_detection = { enabled = false },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- TODO: more from NcChad `lua/plugins/configs/lazy_nvim.lua`
        "gzip",
        "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
