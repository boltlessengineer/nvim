--

-- TODO: activate noice in neovide

if vim.g.neovide then
  vim.schedule(function()
    vim.notify('noice can\'t run on neovide (see #17)')
  end)
  return
end
local ok, noice = pcall(require, 'noice')
if not ok then return end

noice.setup {
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = false, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
  cmdline = {
    enabled = false,
  },
  messages = {
    enabled = false,
  },
  popupmenu = {
    enabled = false,
  },
  redirect = {
    -- TODO: ?
  },
  notify = {
    enabled = false,
  },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
}
