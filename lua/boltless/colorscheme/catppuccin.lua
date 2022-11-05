require('catppuccin').setup {
  flavour = 'mocha', -- latte, frappe, macchiato, mocha
  term_colors = true,
  styles = {
    comments = {},
  },
  color_overrides = {
    -- NOTE: inspired from [nullchilly's config](https://github.com/nullchilly/nvim/blob/nvim/lua/config/catppuccin.lua)
    mocha = {
      -- base = '#000000',
    },
  },
  highlight_overrides = {
    mocha = function(colors)
      return {
        -- TODO: function highlighting in TreesitterContext doesn't work well
        TreesitterContext = { bg = colors.surface0 },
        NvimTreeNormal = { link = 'Normal' },
      }
    end,
  },
  integrations = {
    notify = true,
    illuminate = true,
  },
}
