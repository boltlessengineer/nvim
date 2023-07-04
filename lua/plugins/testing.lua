-- stylua: ignore start
local function neotest() return require('neotest') end
local function toggle_summary() neotest().summary.toggle() end
local function open() neotest().output.open({ enter = true, short = false }) end
local function nearest() neotest().run.run() end
local function run_file() neotest().run.run(vim.fn.expand('%')) end
local function run_file_sync() neotest().run.run({ vim.fn.expand('%'), concurrent = false }) end
local function cancel() neotest().run.stop({ interactive = true }) end
local function next_failed() neotest().jump.next({ status = 'failed' }) end
local function prev_failed() neotest().jump.prev({ status = 'failed' }) end
-- stylua: ignore end

-- TODO: make hydra setup for neotest
return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      { "nvim-neotest/neotest-plenary", dependencies = { "nvim-lua/plenary.nvim" } },
    },
    keys = {
      -- TODO: setup neotest
      { "<leader>ts", toggle_summary, desc = "toggle summary" },
      { "<leader>to", open, desc = "open output" },
      { "<leader>tr", nearest, desc = "run test" },
      { "<leader>tf", run_file, desc = "run file" },
      { "<leader>tF", run_file_sync, desc = "run file (sync)" },
      { "<leader>tc", cancel, desc = "cancel" },
      { "]f", next_failed, desc = "next failed test" },
      { "[f", prev_failed, desc = "prev failed test" },
    },
    opts = {
      adapters = {
        -- TODO: lazyload adapters
        ["neotest-plenary"] = {},
      },
    },
    config = function(_, opts)
      local namespace = vim.api.nvim_create_namespace("neotest")
      vim.diagnostic.config({
        virtual_text = {
          format = function(diagnostic)
            -- Replace newline and tab characters with space for more compact diagnostics
            local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
            return message
          end,
        },
      }, namespace)

      if opts.adapters then
        local adapters = {}
        for name, config in pairs(opts.adapters or {}) do
          if type(name) == "number" then
            if type(config) == "string" then
              config = require(config)
            end
            adapters[#adapters + 1] = config
          elseif config ~= false then
            local adapter = require(name)
            if type(config) == "table" and not vim.tbl_isempty(config) then
              local meta = getmetatable(adapter)
              if adapter.setup then
                adapter.setup(config)
              elseif meta and meta.__call then
                adapter(config)
              else
                error("Adapter " .. name .. " does not support setup")
              end
            end
            adapters[#adapters + 1] = adapter
          end
        end
        opts.adapters = adapters
      end

      require("neotest").setup(opts)
    end,
  },
}
