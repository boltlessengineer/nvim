-- TODO: my own snippets
-- see: https://github.com/max397574/ignis-nvim/blob/master/lua/ignis/modules/completion/snippets/init.lua
return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    build = (not jit.os:find("Windows"))
        and "echo -e 'NOTE: jsregexp is optional, so not a big deal if it fails to build\n'; make install_jsregexp"
      or nil,
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true, silent = true, mode = "i",
      },
      { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function(_, opts)
      local ls = require("luasnip")
      ls.filetype_extend("dart", { "flutter" })
      ls.filetype_extend("NeogitCommitMessage", { "gitcommit" })
      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = { "i:*", "s:n" },
        callback = function(ev)
          if not ls.get_active_snip() then
            return
          end
          if not ls.session.current_nodes[ev.bufnr] or ls.session.jump_active then
            ls.unlink_current()
          end
        end,
      })
      ls.setup(opts)
    end,
  },
  -- snippet creator for LuaSnip
  {
    "ziontee113/SnippetGenie",
    -- HACK: actually make this command... it is fake command now.
    cmd = "SnippetGenie",
    opts = {
      snippets_directory = vim.fn.stdpath("config") .. "/snippets",
    },
  },
}
