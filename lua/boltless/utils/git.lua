_G.GitStatus = {
  head = '',
  upstream = '',
  ahead = 0,
  behind = 0,
}

-- TODO: More options are needed. I can commit git changes **inside** neovim
-- auto refresh git every 2sec (10sec by default & 2sec on neogit enabled maybe)
local M = {
  status = {
    head = '', -- current branch; replaced with `#tag` or `@commit`
    upstream = '', -- remote tracking branch
    ahead = 0, -- ahead the remote
    behind = 0, -- behind the remote
  }
}
function M.get_status()
  return M.status
end

function M.update_git_status()
  local Job = require('plenary.job')
  Job:new({
    command = 'git',
    args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },
    on_exit = function(job, _)
      local res = job:result()[1]
      if type(res) ~= 'string' then
        M.git_status.ahead = 0
        M.git_status.behind = 0
        return
      end
      local ok, ahead, behind = pcall(string.match, res, '(%d+)%s*(%d+)')
      if not ok then ahead, behind = 0, 0 end
      M.git_status.ahead = ahead
      M.git_status.behind = behind
    end,
  }):start()
end

vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
  callback = function()
    vim.fn.jobstart({ 'git', 'status', '-b', '--porcelain=v2' }, {
      -- TODO: error handle
      -- TODO: set GitStatus to null if cwd isn't git repo
      on_stdout = function(_, data)
        if not data then return end
        for _, line in ipairs(data) do
          if line == '' then return end
          local header, value = line:match('# ([%w%.]+) (.+)')
          if header then
            if header == 'branch.head' then
              _G.GitStatus.head = value
            elseif header == 'branch.upstream' then
              _G.GitStatus.upstream = value
            elseif header == 'branch.ab' then
              local ahead, behind = value:match('%+(%d+) %-(%d+)')
              _G.GitStatus.ahead = tonumber(ahead)
              _G.GitStatus.behind = tonumber(behind)
            end
          end
        end
      end,
    })
  end
})
return M
-- NOTE: print guide
-- https://github.com/romkatv/powerlevel10k/blob/master/README.md#what-do-different-symbols-in-git-status-mean
