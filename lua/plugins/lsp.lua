local utils = require("plugins.lsp.utils")

---@type LazyPluginSpec[]
return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = {} },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("utils").has_plugin("nvim-cmp")
        end,
      },
      { "b0o/SchemaStore.nvim", version = false, lazy = true },
    },
    -- stylua: ignore
    _keys = {
      { "<leader>cI", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      -- TODO: toggle inlay hints
      -- { "<leader>ci", desc = "Toggle inlay-hints" },
      { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>cf", require('plugins.lsp.format').format, desc = "Format Document", has = "documentFormatting" },
      { "<leader>cf", require('plugins.lsp.format').format, desc = "Format Range", mode = 'x', has = "documentRangeFormatting" },
      { "<leader>of", require('plugins.lsp.format').toggle, desc = "Toggle Auto Format" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { 'n', 'x' }, has = "codeAction" },
      { "<leader>cr", "<plug>(lsp_rename)", desc = "Rename", mode = { 'n', 'x' }, has = "rename" },
      { "gd", "<plug>(lsp_definitions)", desc = "Goto Definition", has = "definition" },
      { "gy", "<plug>(lsp_type_definitions)", desc = "Goto T[y]pe Definition", has = "typeDefinition" },
      { "gr", "<plug>(lsp_references)", desc = "References", has = "references" },
      { "gi", "<plug>(lsp_implementations)", desc = "Goto Implementations", has = "implementation" },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration", has = "declaration" },
      { "]d", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
      { "[d", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
      { "]e", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Next Error" },
      { "[e", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, desc = "Prev Error" },
      { "]w", function() vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN }) end, desc = "Next Warning" },
      { "[w", function() vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN }) end, desc = "Prev Warning" },
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
      },
      capabilities = {},
      ---@type lspconfig.options
      servers = require("plugins.lsp.servers"),
      ---you can do any additional lsp server setup here
      ---return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {},
    },
    ---@param opts PluginLspOpts
    config = function(plugin, opts)
      -- setup diagnostics
      vim.diagnostic.config(opts.diagnostics)

      utils.on_attach(function(client, buffer)
        require("utils").attach_keymaps(buffer, plugin._keys, function(key)
          local has = key.has
          key.has = nil
          return (not has) or client.server_capabilities[has .. "Provider"]
        end)
        require("plugins.lsp.format").on_attach(client, buffer)
      end)

      local servers = opts.servers
      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities(),
        opts.capabilities or {}
      )
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- 👇 Huge mess of Mason stuffs...

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mlsp_servers = {}
      if have_mason then
        all_mlsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {}
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          ---@diagnostic disable-next-line: undefined-field
          if
            opts.auto_install == false
            or server_opts.mason == false
            or not vim.tbl_contains(all_mlsp_servers, server)
          then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed })
        mlsp.setup_handlers({ setup })
      end
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
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
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jay-babu/mason-null-ls.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local nls = require("null-ls")
      return {
        sources = {
          nls.builtins.formatting.fish_indent,
          nls.builtins.diagnostics.fish,
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.shfmt,
          nls.builtins.formatting.prettierd.with({
            env = {
              PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/utils/linter-config/.prettierrc.json"),
            },
          }),
        },
      }
    end,
    config = function(_, opts)
      require("null-ls").setup(opts)
      require("mason-null-ls").setup({
        ensure_installed = {},
        automatic_installation = true,
      })
    end,
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
      utils.on_attach(function(client, buffer)
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
