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
      return require('packer.util').float { border = 'rounded' }
    end,
  },
}

require('autocmds.external').packer()

packer.startup(function(use)
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/plenary.nvim' -- Useful lua functions used by lots of plugins
  use 'kyazdani42/nvim-web-devicons' -- Dev icons

  -- Colorschemes
  use 'ellisonleao/gruvbox.nvim'

  -- General UIs
  use 'feline-nvim/feline.nvim' -- statusline & winbar

  -- File explorer
  use 'kyazdani42/nvim-tree.lua'
  -- use 'tamago324/lir.nvim' -- Simple file explorer

  -- cmp
  use 'hrsh7th/nvim-cmp' -- The completion plugin
  -- use { 'Shougo/nvim-cmp', branch = 'cmdheight' } -- temporary (#1196)
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
  use 'j-hui/fidget.nvim' -- nvim-lsp progress UI

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

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- Telescope
  use 'nvim-telescope/telescope.nvim'

  use 'numToStr/Comment.nvim' -- Commenting plugin
  -- treesitter based commentstrings
  -- NOTE: Comment.nvim already supports treesitter itself (except tsx/jsx)
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  use 'nvim-treesitter/nvim-treesitter-context' -- sticky header for context
  use 'lukas-reineke/indent-blankline.nvim' -- pretty indentation guides
  use 'rcarriga/nvim-notify' -- notification manager

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
