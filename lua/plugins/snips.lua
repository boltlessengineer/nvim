local ls = require("utils").require.on_index("luasnip")

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
      delete_check_events = "InsertLeave",
    },
    -- stylua: ignore
    keys = {
      {
        "<c-l>",
        function()
          if ls.locally_jumpable() then
            ls.jump(1)
          end
        end,
        mode = "i",
      },
      { "<c-l>", function() ls.jump(1) end, mode = "s" },
      { "<c-h>", function() ls.jump(-1) end, mode = { "i", "s" } },
    },
    config = function(_, opts)
      ls.filetype_extend("dart", { "flutter" })
      ls.filetype_extend("NeogitCommitMessage", { "gitcommit" })
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
