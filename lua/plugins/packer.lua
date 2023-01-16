local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local compile_path = fn.stdpath 'data'
    .. '/site/pack/loader/start/packer/plugin/packer_compiled.lua'

-- Automatically install packer
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  vim.notify 'Installing packer...'
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't get error on first run
local ok, packer = pcall(require, 'packer')
if not ok then return end

-- Have packer use a popup window
packer.init {
  compile_path = compile_path,
  display = {
    open_fn = function()
      -- TODO: PR to packer.nvim winhighlight option like nvim-cmp
      return require('packer.util').float {
        border = vim.g.borderstyle,
        -- winhighlight = is_bordered() and { Normal = 'Normal' }
      }
    end,
  },
}

require('autocmds.external').packer()

-- TODO: try `packer.setup(config, plugins)` (see https://github.com/folke/dot/blob/8d343c36e6ff4109f0585a4828f49ca7b89c1ece/config/nvim/lua/config/plugins.lua)
packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'lewis6991/impatient.nvim' -- Blazingly fast startup
  use 'nvim-lua/plenary.nvim' -- Useful lua functions used by lots of plugins
  use 'kyazdani42/nvim-web-devicons' -- Dev icons

  -- Colorschemes
  -- TODO: check theme list
  -- NOTE: https://www.reddit.com/r/neovim/comments/ydnip2/whats_your_recommendations_for_good_colorschemes
  --
  -- - Noctis (kartikp10/noctis.nvim)
  -- - Enfocado (wuelnerdotexe/vim-enfocado)
  -- - Edge (sainnhe/edge)
  -- - Github (projekt0n/github-nvim-theme)
  -- - Oxocarbon
  -- - Night Wolf Dark (VSCode theme)
  -- - habamax (best default theme)
  use 'rebelot/kanagawa.nvim'
  use 'kvrohit/mellow.nvim'
  use 'sainnhe/gruvbox-material'
  -- use 'Yazeed1s/minimal.nvim'
  use { 'rose-pine/neovim', as = 'rose-pine' }
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use {
    'mcchrish/zenbones.nvim',
    requires = 'rktjmp/lush.nvim'
  }

  -- General UIs
  use 'rebelot/heirline.nvim' -- statusline, winbar, tabline

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'
  -- use 'tamago324/lir.nvim' -- Simple file explorer
  use 'prichrd/netrw.nvim' -- Default Netrw with a layer of *bling*

  -- cmp
  use 'hrsh7th/nvim-cmp' -- The completion plugin
  use 'hrsh7th/cmp-path' -- path completions
  use 'hrsh7th/cmp-cmdline' -- cmdline completions
  use 'hrsh7th/cmp-nvim-lsp' -- LSP completions
  use 'hrsh7th/cmp-nvim-lua' -- nvim-lua completions
  use 'saadparwaiz1/cmp_luasnip' -- snippet completions
  -- snippets
  use 'L3MON4D3/LuaSnip' -- snippet engine
  use 'rafamadriz/friendly-snippets' -- a bunch of snippets to use

  -- LSP
  use 'neovim/nvim-lspconfig' -- enable LSP
  use 'RRethy/vim-illuminate' -- auto-highlight word under cursor

  -- DAP
  -- TODO: add DAP stuffs here

  -- Linters
  -- TODO: nvim-lint

  -- Formatters
  -- TODO: formatter.nvim

  -- Mason
  -- package manager for LSP, DAP, and etc
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  }

  use 'joechrisellis/lsp-format-modifications.nvim' -- format modifications

  -- Treesitter
  -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-treesitter/playground',
    -- NOTE: Comment.nvim already supports treesitter itself (except tsx/jsx)
    'JoosepAlviste/nvim-ts-context-commentstring', -- treesitter based commentstrings
    'nvim-treesitter/nvim-treesitter-context', -- sticky header for context
    'p00f/nvim-ts-rainbow', -- rainbow parentheses {}
    requires = 'nvim-treesitter/nvim-treesitter'
  }
  use {
    'nvim-treesitter/nvim-treesitter-textobjects', -- Aware text-object
    requires = 'nvim-treesitter/nvim-treesitter',
  }

  -- Language specific
  use 'folke/neodev.nvim' -- full signature help for neovim config developing
  use 'folke/neoconf.nvim' -- local/global settings (both json & lua)
  use 'b0o/schemastore.nvim' -- schemastore

  -- Git
  use 'lewis6991/gitsigns.nvim'
  use 'TimUntersberger/neogit'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'

  use 'numToStr/Comment.nvim' -- Commenting plugin

  use 'kylechui/nvim-surround' -- surround plugin

  use 'SmiteshP/nvim-navic' -- LSP based code context
  use 'norcalli/nvim-colorizer.lua' -- colorize hex colors
  use 'lukas-reineke/indent-blankline.nvim' -- pretty indentation guides
  use {
    'folke/noice.nvim',
    requires = {
      'MunifTanjim/nui.nvim',
      -- 'rcarriga/nvim-notify', -- notification manager
    }
  }
  use 'rcarriga/nvim-notify' -- notification manager
  use 'goolord/alpha-nvim' -- startup screen

  use 'folke/trouble.nvim' -- pretty list
  use 'folke/todo-comments.nvim' -- highlight & list todos
  use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' } -- modern looking folds

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
