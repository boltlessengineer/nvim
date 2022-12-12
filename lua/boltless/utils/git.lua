local Job = require('plenary.job')

_G.GitStatus = {
  enabled = false,
  head = '', -- current branch; replaced with `#tag` or `@commit`
  upstream = '', -- remote tracking branch
  ahead = 0, -- ahead the remote
  behind = 0, -- behind the remote
  stash = 0, -- total stashes
}

function _G.update_head()
  Job:new({
    command = 'git',
    args = { 'branch', '--show-current' },
    on_stderr = function()
      _G.GitStatus.enabled = false
    end,
    on_exit = function(job, return_val)
      if return_val == 0 then
        _G.GitStatus.enabled = true
        _G.GitStatus.head = job:result()[1]
      end
    end,
  }):sync()
end

-- update ahead/behind count from @{upstream}
local function update_ab_count()
  Job:new({
    command = 'git',
    args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
    on_exit = function(job, _)
      local res = job:result()[1]
      if type(res) ~= 'string' then
        _G.GitStatus.ahead = 0
        _G.GitStatus.behind = 0
        return
      end
      local ok, ahead, behind = pcall(string.match, res, '(%d+)%s*(%d+)')
      if not ok then ahead, behind = 0, 0 end
      _G.GitStatus.ahead = tonumber(ahead)
      _G.GitStatus.behind = tonumber(behind)
    end,
  }):start()
end

local function update_stashes()
  Job:new({
    command = 'git',
    args = { 'stash', 'list' },
    on_exit = function(job, _)
      local count = #(job:result())
      if type(count) == 'number' then
        _G.GitStatus.stash = count
      end
    end,
  }):start()
end

-- auto refresh git every 2sec
if _G.Gstatus_timer == nil then
  _G.Gstatus_timer = vim.loop.new_timer()
else
  _G.Gstatus_timer:stop()
end

_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(function()
  update_head()
  if not _G.GitStatus.enabled then return end
  -- update_remote()
  update_ab_count()
  update_stashes()
end))
