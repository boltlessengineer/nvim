local Utils = require("utils")
local icons = require("config.icons")

---this will return a function that calls telescope
---cwd will default to util.root()
---@param builtin string
---@param opts? any
---@return function
local function telescope(builtin, opts)
  -- TOOD: use git_files to properly gitignore files (like submodules)
  return function()
    opts = vim.tbl_deep_extend("force", { cwd = Utils.root.get() }, opts or {})
    require("telescope.builtin")[builtin](opts)
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = { "MunifTanjim/nui.nvim" },
    keys = {
      -- FIX: these don't load Telescope
      { "<plug>(lsp_definitions)", "<cmd>Telescope lsp_definitions<cr>" },
      { "<plug>(lsp_type_definitions)", "<cmd>Telescope lsp_type_definitions<cr>" },
      { "<plug>(lsp_references)", "<cmd>Telescope lsp_references<cr>" },
      { "<plug>(lsp_implementations)", "<cmd>Telescope lsp_implementations<cr>" },
      { "<F1>", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>,", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      -- TODO: change to `<leader>ff`
      -- and add directory-specific keymap `<leader>fd`
      { "<leader>ff", telescope("find_files"), desc = "Find files (root dir)" },
      { "<leader>fc", "<cmd>Telescope find_files<cr>", desc = "Find files (cwd)" },
      -- { "<leader>fd", "<cmd>Telescope find_dir<cr>", desc = "Find Dir (cwd)" },
      { "<leader>e", telescope("find_files"), desc = "Find files (root dir)" },
      { "<leader>E", "<cmd>Telescope find_files<cr>", desc = "Find files (cwd)" },
      { "<leader>gl", "<cmd>Telescope git_commits<cr>", desc = "Logs" },
      { "<leader>gs", "<cmd>Telescope git_status<cr>", desc = "Status" },
      -- TODO: disable preview
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current Buffer Fuzzy" },
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
        "<leader>cs",
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
        "<leader>cS",
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
    opts = {
      pickers = {
        find_files = {
          hidden = true,
        },
        git_files = {
          show_untracked = true,
        },
        buffers = {
          mappings = {
            i = {
              -- ["<cs-d>"] = "delete_buffer",
              -- TODO: delete buffer from telescope
              -- see: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mapping-c-d-to-delete-buffer
            }
          }
        }
      },
      defaults = {
        file_ignore_patterns = {
          "^.git/",
          "^node_modules/",
        },
        prompt_prefix = icons.telescope.prompt_prefix,
        selection_caret = icons.telescope.selection_caret,
        results_title = false,
        mappings = {
          i = {
            ["<c-s>"] = "select_horizontal",
            ["<c-t>"] = "select_tab",
            ["<c-a>"] = "select_all",
            -- TODO: should I "add" instead of "send"?
            ["<c-q>"] = "send_to_qflist",
            ["<cs-q>"] = "send_selected_to_qflist",
            -- ["<ESC>"] = "close",
            ["<PageUp>"] = false,
            ["<PageDown>"] = false,
            ["<C-X>"] = false,
          },
          n = {
            ["q"] = "close",
          },
        },
        -- layout_strategy = "bottom_horizontal",
        layout_config = {
          anchor = 'S',
          horizontal = {
            prompt_position = "top",
            -- make width 100%
            width = 99999999,
            height = 0.5,
          },
          vertical = {
            -- width = 0,
            height = 25,
          },
        },
        sorting_strategy = "ascending",
        -- FIX:
        -- 1. remove nui.nvim
        -- 2. make it use configured border chars, border options
        _create_layout = function(picker)
          local Layout = require("nui.layout")
          local Popup = require("nui.popup")
          local TSLayout = require("telescope.pickers.layout")
          local resolve = require("telescope.config.resolve")
          ---@param options nui_popup_options
          ---@return TelescopeWindow
          local function make_popup(options)
            local popup = Popup(options)--[[@as table]]
            function popup.border:change_title(title)
              popup.border:set_text(popup.border, "top", title)
            end
            return TSLayout.Window(popup)
          end
          local border_size = picker.window.border == false and 0 or 1
          local border = {
            prompt = {
              top_left = "┌",
              top = "─",
              top_right = "┬",
              right = "│",
              bottom_right = "",
              bottom = "",
              bottom_left = "",
              left = "│",
            },
            prompt_patch = {
              minimal = {
                top_left = "┌",
                top_right = "┐",
              },
              vertical = {
                top_left = "┌",
                top_right = "┐",
              },
              center = {
                top_left = "┌",
                top_right = "┐",
              },
              horizontal = {
                top_left = "┌",
                top_right = "┬",
              },
            },
            results = {
              top_left = "├",
              top = "─",
              top_right = "┤",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            results_patch = {
              minimal = {
                bottom_right = "┘",
              },
              vertical = {
                bottom_right = "┘",
              },
              center = {
                bottom_right = "┘",
              },
              horizontal = {
                bottom_right = "┴",
              },
            },
            preview = {
              top_left = "┌",
              top = "─",
              top_right = "┐",
              right = "│",
              bottom_right = "┘",
              bottom = "─",
              bottom_left = "└",
              left = "│",
            },
            preview_patch = {
              minimal = {},
              center = {},
              vertical = {
                bottom_right = "┘",
              },
              horizontal = {
                bottom = "─",
                bottom_left = "",
                bottom_right = "┘",
                left = "",
                top_left = "",
              },
            },
          }
          local results = make_popup({
            focusable = false,
            border = {
              style = border.results,
              text = {
                top = picker.results_title,
                top_align = "center",
              },
            },
          })
          local prompt = make_popup({
            enter = true,
            border = {
              style = border.prompt,
              text = {
                top = picker.prompt_title,
                top_align = "center",
              },
            },
          })
          local preview = make_popup({
            focusable = false,
            border = {
              style = border.preview,
              text = {
                top = picker.preview_title,
                top_align = "center",
              },
            },
          })
          local box_by_kind = {
            vertical = Layout.Box({
              Layout.Box(preview, { grow = 1 }),
              Layout.Box(prompt, { size = 1 + border_size }),
              Layout.Box(results, { grow = 1 }),
            }, { dir = "col" }),
            horizontal = Layout.Box({
              Layout.Box({
                Layout.Box(prompt, { size = 1 + border_size }),
                Layout.Box(results, { grow = 1 }),
              }, { dir = "col", size = "40%" }),
              Layout.Box(preview, { grow = 1 }),
            }, { dir = "row" }),
            minimal = Layout.Box({
              Layout.Box(prompt, { size = 1 + border_size }),
              Layout.Box(results, { grow = 1 }),
            }, { dir = "col" }),
            center = Layout.Box({
              Layout.Box(prompt, { size = 1 + border_size }),
              Layout.Box(results, { grow = 1 }),
            }, { dir = "col" }),
          }
          local function get_box()
            local strategy = picker.layout_strategy
            if not box_by_kind[strategy] then
              strategy = picker.preview and "horizontal" or "minimal"
            end
            if strategy == "horizontal" and vim.o.columns < 100 then
              strategy = "minimal"
            end
            return box_by_kind[strategy], strategy
          end
          local function prepare_layout_parts(layout, strategy)
            layout.prompt = prompt
            layout.results = results
            prompt
              .border--[[@as NuiPopupBorder]]
              :set_style(border.prompt_patch[strategy])
            results
              .border--[[@as NuiPopupBorder]]
              :set_style(border.results_patch[strategy])
            if strategy == "minimal" then
              layout.preview = nil
            else
              layout.preview = preview
              preview
                .border--[[@as NuiPopupBorder]]
                :set_style(border.preview_patch[strategy])
            end
          end
          local function get_layout_size(strategy)
            strategy = strategy == "minimal" and "vertical" or strategy
            local layout_config = picker.layout_config[strategy]
            local width = resolve.resolve_width(layout_config.width)(picker, vim.o.columns, vim.o.lines)
            local height = resolve.resolve_height(layout_config.height)(picker, vim.o.columns, vim.o.lines)
            return {
              width = width == 0 and vim.o.columns or width,
              height = height == 0 and vim.o.lines or height,
            }
          end
          local function get_layout_pos(strategy, size)
            strategy = strategy == "minimal" and "vertical" or strategy
            return strategy == "center" and "50%"
              or {
                col = "50%",
                row = vim.o.lines - size.height - vim.o.cmdheight - (vim.o.laststatus % 2),
              }
          end
          local box, strategy = get_box()
          local layout_opts = {
            relative = "editor",
            size = get_layout_size(strategy),
          }
          layout_opts.position = get_layout_pos(strategy, layout_opts.size)

          local layout = Layout(layout_opts, box) --[[@as table]]
          layout.picker = picker
          prepare_layout_parts(layout, strategy)
          local layout_update = layout--[[@as NuiLayout]].update
          function layout:update()
            local box_, strategy_ = get_box()
            if strategy_ == "minimal" then
              self.preview:unmount()
              self.preview = nil
            end
            prepare_layout_parts(self, strategy_)
            local size = get_layout_size(strategy_)
            layout_update(self, {
              position = get_layout_pos(strategy_, size),
              size = size,
            }, box_)
          end
          vim.api.nvim_create_autocmd("FocusLost", {
            callback = function()
              if not layout then
                return true
              end
              layout:update()
            end,
          })
          return TSLayout(layout)
        end,
      },
    },
  },
}
