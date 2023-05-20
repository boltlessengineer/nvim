local disable_plugins = {
  -- hate feature
  "akinsho/bufferline.nvim",
  "nvim-lualine/lualine.nvim",
  "echasnovski/mini.indentscope",
  "windwp/nvim-spectre",
  "RRethy/vim-illuminate",
  "nvim-neo-tree/neo-tree.nvim",
  "SmiteshP/nvim-navic",

  -- replaced with other plugins
  "echasnovski/mini.comment",
  "echasnovski/mini.surround",
  "echasnovski/mini.pairs",
}

local spec = {
  {
    "LazyVim/LazyVim",
    opts = {
      defaults = {
        keymaps = false,
        autocmds = false,
      },
    },
  },
}

for _, v in ipairs(disable_plugins) do
  spec[#spec + 1] = { v, enabled = false }
end

return spec
