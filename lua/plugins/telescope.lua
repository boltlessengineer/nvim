local Utils = require("utils")

---this will return a function that calls telescope
---cwd will default to utils.get_root
---@param builtin string
---@param opts? any
---@return function
local function telescope(builtin, opts)
  return function()
    opts = vim.tbl_deep_extend("force", { cwd = Utils.get_root() }, opts or {})
    require("telescope.builtin")[builtin](opts)
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<plug>(lsp_definitions)", "<cmd>Telescope lsp_definitions<cr>" },
      { "<plug>(lsp_type_definitions)", "<cmd>Telescope lsp_type_definitions<cr>" },
      { "<plug>(lsp_references)", "<cmd>Telescope lsp_references<cr>" },
      { "<plug>(lsp_implementations)", "<cmd>Telescope lsp_implementations<cr>" },
      { "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>f", telescope("find_files"), desc = "Find files (root dir)" },
      { "<leader>F", "<cmd>Telescope find_files<cr>", desc = "Find files (cwd)" },
      { "<leader>gl", "<cmd>Telescope git_commits<cr>", desc = "Logs" },
      { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>sf", telescope("find_files"), desc = "Find files (root dir)" },
      { "<leader>sR", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
      { "<leader>sw", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Highlight Groups" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sg", telescope("live_grep"), desc = "Grep (root dir)" },
      { "<leader>sG", telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
      {
        "<leader>ss",
        telescope("lsp_document_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol",
      },
      {
        "<leader>sS",
        telescope("lsp_dynamic_workspace_symbols", {
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        }),
        desc = "Goto Symbol (Workspace)",
      },
    },
    -- TODO: show linenumber in telescope preview window
    -- also, telescope window will be almost full screen (auto-resize on VimResized)
    opts = function(_, opts)
      local actions = require("telescope.actions")
      opts.defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          -- TODO: remove unused Telescope-local keymaps
          i = {
            ["<c-s>"] = actions.select_horizontal,
            ["<c-t>"] = actions.select_tab,
            ["<c-q>"] = actions.send_selected_to_qflist,
            ["<ESC>"] = actions.close,
            ["<c-c>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      }
      opts.pickers = {
        find_files = {
          hidden = true,
        },
        git_files = {
          show_untracked = true,
        },
      }
      return opts
    end,
  },
}
