package.loaded["utils.highlights"] = nil
local util_hl = require("utils.highlights")
local Util = require("utils")
local ui = require("config.ui")

local hls = {
  lsp_box = "StlLspBox",
  lsp_box_none = "StlLspBoxNone",
}

local function set_colors()
  -- local fg = { from = "StatusLine", attr = "fg" }
  local bg = { from = "StatusLine", attr = "bg" }
  -- local ncfg = { from = "StatusLineNC", attr = "fg" }
  -- local ncbg = { from = "StatusLineNC", attr = "bg" }
  local map = {
    [hls.lsp_box] = { fg = bg, bg = ui.palette.blue, bold = true },
    [hls.lsp_box_none] = { fg = bg, bg = ui.palette.blue, bold = true },
  }
  util_hl.all(map)
end

util_hl.plugin_wrap("statusline", set_colors)

local function message()
  if package.loaded["noice"] and require("noice").api.status.message.has() then
    return require("noice").api.status.message.get_hl()
    -- TODO: break down to get_hl function,
    -- read hlgroup and make new hlgroup for it (cache group to use later)
  end
  return nil
end

local function mode()
  if package.loaded["noice"] and require("noice").api.status.mode.has() then
    return vim.trim(require("noice").api.status.mode.get())
  end
  return nil
end

local function services()
  local is_file = vim.bo.buftype == ""
  local active_clients = vim.lsp.get_clients(is_file and { bufnr = 0 } or nil)

  local client_names = {}
  for _, client in ipairs(active_clients) do
    client_names[#client_names + 1] = client.name
  end

  local ok, conform = pcall(require, "conform")
  if ok then
    local formatters = conform.list_formatters()
    for _, formatter in ipairs(formatters) do
      client_names[#client_names + 1] = formatter.name
    end
  end

  if #client_names == 0 then
    return util_hl.hl_text(" LSP Inactive ", "StlLspBoxNone")
  end

  return util_hl.hl_text(" " .. table.concat(client_names, ", ") .. " ", "StlLspBox")
end

local function tab_info()
  local space_str = "Spaces"
  local tab_str = "Tab"
  local opt = vim.bo.buftype == "" and vim.bo or vim.o
  local tabkind = opt.expandtab and space_str or tab_str
  local tabsize = opt.shiftwidth
  return string.format("%s:%d", tabkind, tabsize)
end

local function root_dir()
  local root = Util.root()
  -- TODO: replace some paths with $HOME, $PROJECTS, $DOTFILES, $REPO
  -- see akinsho's config
  local xdg_config = vim.env.XDG_CONFIG or vim.fs.joinpath(vim.env.HOME, ".config")
  local vim_dotfiles = vim.fs.joinpath(xdg_config, vim.env.NVIM_APPNAME or "nvim", "")
  -- TODO: if target path is symlink, also check if current path is origin path
  local paths = {
    [vim.env.HOME] = "$HOME",
    [vim.env.VIMRUNTIME] = "$VIMRUNTIME",
    [vim_dotfiles] = "$NVIM_CONFIG",
    [xdg_config] = "$DOTFILES",
    [vim.fs.joinpath(vim.env.HOME, "Projects")] = "$PROJECTS",
    [vim.fs.joinpath(vim.env.HOME, "projects")] = "$PROJECTS",
  }
  -- sort by key
  return root
end

function _G.statusline()
  local modules = {
    "",
    root_dir(),
    util_hl.hl_text("%=%S", "StatusLine"), -- ensure hl
    mode(),
    services(),
    tab_info(),
    "",
  }
  return table.concat(
    vim.tbl_filter(function(i)
      return i ~= nil
    end, modules),
    " "
  )
end

vim.o.showcmdloc = "statusline"
vim.o.statusline = "%{%v:lua.statusline()%}"

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.statusline = "%{%v:lua.statusline()%}"
  end,
})
