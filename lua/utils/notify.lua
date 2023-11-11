---@class bt.util.notify
local M = {}

---@alias BtNotifyOpts {lang?:string, title?:string, level?:number, once?:boolean, stacktrace?:boolean, stacklevel?:number}

---@param msg string|string[]
---@param opts? BtNotifyOpts
function M.md_notify(msg, opts)
  if vim.in_fast_event() then
    return vim.schedule(function()
      M.md_notify(msg, opts)
    end)
  end

  opts = opts or {}
  if type(msg) == "table" then
    msg = table.concat(
      vim.tbl_filter(function(line)
        return line or false
      end, msg),
      "\n"
    )
  end
  local lang = opts.lang or "markdown"
  local n = opts.once and vim.notify_once or vim.notify
  n(msg, opts.level or vim.log.levels.INFO, {
    on_open = function(win)
      local ok = pcall(function()
        vim.treesitter.language.add("markdown")
      end)
      if not ok then
        pcall(require, "nvim-treesitter")
      end
      vim.wo[win].conceallevel = 3
      vim.wo[win].concealcursor = ""
      vim.wo[win].spell = false
      local buf = vim.api.nvim_win_get_buf(win)
      if not pcall(vim.treesitter.start, buf, lang) then
        vim.bo[buf].filetype = lang
        vim.bo[buf].syntax = lang
      end
    end,
    title = opts.title or "config",
  })
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
function M.error(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.ERROR
  M.md_notify(msg, opts)
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
function M.info(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.INFO
  M.md_notify(msg, opts)
end

---@param msg string|string[]
---@param opts? LazyNotifyOpts
function M.warn(msg, opts)
  opts = opts or {}
  opts.level = vim.log.levels.WARN
  M.md_notify(msg, opts)
end

return M
