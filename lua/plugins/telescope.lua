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
      -- FIX: these don't load Telescope
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
    opts = {
      defaults = {
        file_ignore_patterns = { "^.git/" },
        prompt_prefix = " ",
        selection_caret = " ",
        mappings = {
          i = {
            ["<c-s>"] = "select_horizontal",
            ["<c-t>"] = "select_tab",
            ["<c-q>"] = "send_selected_to_qflist",
            ["<ESC>"] = "close",
            ["<Up>"] = false,
            ["<Down>"] = false,
            ["<PageUp>"] = false,
            ["<PageDown>"] = false,
            ["<C-X>"] = false,
          },
          n = {
            ["q"] = "close",
          },
        },
        -- TODO: use bottom_pane by default
        layout_strategy = "bottom_horizontal",
        layout_config = {
          bottom_horizontal = {
            height = 25,
            preview_cutoff = 120,
            prompt_position = "top",
          },
        },
        sorting_strategy = "ascending",
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        git_files = {
          show_untracked = true,
        },
      },
    },
    config = function(_, opts)
      local function get_border_size(picker)
        if picker.window.border == false then
          return 0
        end
        return 1
      end

      local function calc_tabline(max_lines)
        local tbln = (vim.o.showtabline == 2) or (vim.o.showtabline == 1 and #vim.api.nvim_list_tabpages() > 1)
        if tbln then
          max_lines = max_lines - 1
        end
        return max_lines, tbln
      end

      ---Helper function for capping over/undersized width/height, and calculating spacing
      ---@param cur_size number size of capped
      ---@param max_size number the maximum size, e.g. max_lines or max_columns
      ---@param bs number the size of the border
      ---@param w_num number the maximum number of windows of the picker in the given direction
      ---@param b_num number the number of border rows/column in the given direction (when border enabled)
      ---@param s_num number the number of gaps in the given direction (when border disabled)
      ---@return number cur_size
      ---@return number spacing
      local function calc_size_and_spacing(cur_size, max_size, bs, w_num, b_num, s_num)
        local spacing = s_num * (1 - bs) + b_num * bs
        cur_size = math.min(cur_size, max_size)
        cur_size = math.max(cur_size, w_num + spacing)
        return cur_size, spacing
      end

      -- HACK: get layout_config in more proper way
      local layout_config = opts.defaults.layout_config.bottom_horizontal
      require("telescope.pickers.layout_strategies").bottom_horizontal = function(picker, max_columns, max_lines, _)
        local resolve = require("telescope.config.resolve")
        local initial_options = require("telescope.pickers.window").get_initial_window_options(picker)
        local preview = initial_options.preview
        local prompt = initial_options.prompt
        local results = initial_options.results

        local tbln
        max_lines, tbln = calc_tabline(max_lines)
        local bs = get_border_size(picker)

        local height_opt = layout_config.height
        local height = resolve.resolve_height(height_opt)(picker, max_columns, max_lines)

        -- Height
        prompt.height = 1
        results.height = height - prompt.height - (3 * bs)
        preview.height = height - (2 * bs)

        -- Width
        if picker.previewer and (max_columns >= layout_config.preview_cutoff) then
          -- Cap over/undersized width (with preview)
          local width, w_space = calc_size_and_spacing(max_columns, max_columns, bs, 2, 3, 1)
          preview.width =
            resolve.resolve_width(vim.F.if_nil(layout_config.preview_width, 0.6))(picker, width, max_lines)
          prompt.width = width - preview.width - w_space
        else
          preview.width = 0
          prompt.width = max_columns - 2 * bs
        end
        results.width = prompt.width

        results.borderchars = vim.deepcopy(results.borderchars)
        preview.borderchars = vim.deepcopy(preview.borderchars)

        -- Line
        if layout_config.prompt_position == "top" then
          prompt.line = max_lines - results.height - (1 + bs)
          results.line = prompt.line + prompt.height + bs
          preview.line = prompt.line
          if results.border and preview.border then
            results.borderchars[5] = "├"
            results.borderchars[6] = "┤"
            if picker.previewer and preview.width > 0 then
              results.borderchars[7] = "┴"
            end
            preview.borderchars[5] = "┬"
          end
          results.title = nil
        elseif layout_config.prompt_position == "bottom" then
          results.line = max_lines - results.height - (1 + bs)
          prompt.line = max_lines - bs
          preview.line = results.line
          if results.border and preview.border then
            results.borderchars[6] = "┬"
            results.borderchars[7] = "┤"
            results.borderchars[8] = "├"
            preview.borderchars[8] = "┴"
          end
        else
          error(
            string.format("Unkown prompt_position: %s\n%s", picker.window.prompt_position, vim.inspect(layout_config))
          )
        end

        -- Col
        prompt.col = 1 + bs
        if layout_config.mirror and preview.width > 0 then
          preview.col = bs + 1
          results.col = preview.width + (3 * bs)
        else
          results.col = bs + 1
          preview.col = results.width + (3 * bs)
        end

        if tbln then
          prompt.line = prompt.line + 1
          results.line = results.line + 1
          preview.line = preview.line + 1
        end

        return {
          preview = (picker.previewer and preview.width > 0) and preview,
          prompt = prompt,
          results = results,
        }
      end
      require("telescope").setup(opts)
    end,
  },
}
