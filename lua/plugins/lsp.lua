local Util = require("utils")

---@type LazyPluginSpec[]
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = {} },
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return Util.plugin.has("nvim-cmp")
        end,
      },
      -- NOTE: mason dependency is needed to use mason-installed servers
      "williamboman/mason.nvim",
      ---@diagnostic disable-next-line: assign-type-mismatch
      { "b0o/SchemaStore.nvim", version = false, lazy = true },
    },
    -- stylua: ignore
    _keys = {
      { "K", vim.lsp.buf.hover, desc = "hover" },
      { "<leader>cI", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      -- TODO: toggle inlay hints
      -- { "<leader>ci", desc = "Toggle inlay-hints" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { 'n', 'x' }, has = "codeAction" },
      { "<leader>cr", "<plug>(lsp_rename)", desc = "Rename", mode = { 'n', 'x' }, has = "rename" },
      { "gd", "<plug>(lsp_definitions)", desc = "Goto Definition", has = "definition" },
      { "gy", "<plug>(lsp_type_definitions)", desc = "Goto T[y]pe Definition", has = "typeDefinition" },
      { "gr", "<plug>(lsp_references)", desc = "References", has = "references" },
      { "gI", "<plug>(lsp_implementations)", desc = "Goto Implementations", has = "implementation" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration", has = "declaration" },
      { "<C-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help" },
    },
    init = function()
      -- these are initially mapped default functions
      -- and can be replaced to alternative lazy-loaded plugins
      local function default(name, cmd)
        vim.keymap.set("", "<plug>(" .. name .. ")", cmd)
      end
      default("lsp_rename", vim.lsp.buf.rename)
      default("lsp_definitions", vim.lsp.buf.definition)
      default("lsp_type_definitions", vim.lsp.buf.type_definition)
      default("lsp_references", vim.lsp.buf.references)
      default("lsp_implementations", vim.lsp.buf.implementation)
    end,
    ---@class PluginLspOpts
    opts = {
      auto_install = false,
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          -- stylua: ignore
          prefix = vim.fn.has("nvim-0.10.0") == 0 and "●" or function(diagnostic)
            local icons = require("config.icons").diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end,
        },
        -- virtual_text = false,
        virtual_lines = false,
        severity_sort = true,
        -- TODO: neovim/neovim#25869 full line highlight for diagnostics
      },
      capabilities = {},
      ---@type lspconfig.options
      servers = require("plugins.lsp.servers"),
      ---you can do any additional lsp server setup here
      ---return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {},
    },
    ---@param plugin PluginLspOpts|table<string,table>
    ---@param opts PluginLspOpts
    config = function(plugin, opts)
      -- setup diagnostics
      vim.diagnostic.config(opts.diagnostics)

      -- attach keymaps
      Util.lsp.on_attach(function(client, buffer)
        Util.attach_keymaps(buffer, plugin._keys, function(key)
          local has = key.has
          key.has = nil
          return (not has) or client.server_capabilities[has .. "Provider"]
        end)
      end)

      -- register lsp formatter
      Util.format.register(Util.lsp.formatter())

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

      -- HACK: if there are type errors with capabilities/server_opts,
      -- that maybe from catppuccin's `vim.tbl_deep_extend` overwrite
      -- dirty fix:
      --
      ---@diagnostic disable: param-type-mismatch
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
          -- handlers = {
          --   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
          --   ["textDocument/signature_help"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
          -- }
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      for server, _ in pairs(servers) do
        setup(server)
      end
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    enabled = false,
    event = "LspAttach",
    keys = {
      {
        "<leader>cl",
        function()
          local config = vim.diagnostic.config().virtual_lines
          if not config then
            vim.diagnostic.config({ virtual_lines = { only_current_line = true } })
          else
            vim.diagnostic.config({ virtual_lines = false })
          end
        end,
        desc = "Toggle diagnostics",
      },
    },
    config = true,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {
      ensure_installed = {},
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },
  {
    "VidocqH/lsp-lens.nvim",
    event = "LspAttach",
    enabled = false,
  },
  {
    "joechrisellis/lsp-format-modifications.nvim",
    event = "LspAttach",
    opts = {
      format_on_save = false,
    },
    init = function()
      -- TODO: use modification format
      vim.g.format_modi = false
    end,
    config = function(_, opts)
      local local_opts = vim.deepcopy(opts)
      Util.lsp.on_attach(function(client, buffer)
        if client.supports_method("textDocument/rangeFormatting") then
          if client.name == "lua_ls" then
            local_opts.experimental_empty_line_handling = true
          end
          require("lsp-format-modifications").attach(client, buffer, local_opts)
          vim.b._lsp_format_modi_attached = true
        end
      end)
    end,
  },
  {
    "smjonas/inc-rename.nvim",
    event = "LspAttach",
    dependencies = "stevearc/dressing.nvim",
    opts = {
      input_buffer_type = "dressing",
    },
    config = function(opts)
      local inc_rename = require("inc_rename")
      inc_rename.setup(opts)
      vim.keymap.set({ "n", "x" }, "<plug>(lsp_rename)", function()
        return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "Rename" })
    end,
  },
}
