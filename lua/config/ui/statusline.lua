package.loaded["utils.highlights"] = nil
local util_hl = require("utils.highlights")
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
    -- read hlgroup and make new hlgroup for it (cache group to use lator)
  end
  return nil
end

local function mode()
  if package.loaded["noice"] and require("noice").api.status.mode.has() then
    return vim.trim(require("noice").api.status.mode.get())
  end
  return nil
end

local function lsp_servers()
  local filter
  -- filter to current buffer on file buffers
  if vim.bo.buftype == "" then
    filter = { bufnr = 0 }
  end
  local active_clients = vim.lsp.get_active_clients(filter)

  local client_names = {}
  for _, client in ipairs(active_clients) do
    -- HACK: ignroe null-ls for now
    if client.name ~= "null-ls" then
      client_names[#client_names + 1] = client.name
    end
  end

  if #client_names == 0 then
    return util_hl.hl_text("StlLspBoxNone", " LSP Inactive ")
  end

  return util_hl.hl_text("StlLspBox", " " .. table.concat(client_names, ", ") .. " ")
end

-- TODO: LspAttach -> update null-ls server client's attached_buffer list
-- ... or just don't use null-ls

local function tab_info()
  local space_str = "Spaces"
  local tab_str = "Tab"
  local opt = vim.o
  if vim.bo.buftype == "" then
    opt = vim.bo
  end
  local tabkind = opt.expandtab and space_str or tab_str
  local tabsize = opt.shiftwidth
  return string.format("%s:%d", tabkind, tabsize)
end

function _G.statusline()
  local modules = {
    "",
    message(),
    util_hl.hl_text("StatusLine", "%=%S"), -- ensure hl
    mode(),
    lsp_servers(),
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
