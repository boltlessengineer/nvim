local fn = vim.fn
local d = {}

GitStatus = {
  head = '',
  upstream = '',
  ahead = 0,
  behind = 0,
}
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
              GitStatus.head = value
            elseif header == 'branch.upstream' then
              GitStatus.upstream = value
            elseif header == 'branch.ab' then
              local ahead, behind = value:match('%+(%d+) %-(%d+)')
              GitStatus.ahead = tonumber(ahead)
              GitStatus.behind = tonumber(behind)
            end
          end
        end
      end,
    })
  end
})
-- NOTE: print guide
-- https://github.com/romkatv/powerlevel10k/blob/master/README.md#what-do-different-symbols-in-git-status-mean
--[[
local chan = fn.jobstart({ 'git', 'status', '-b', '--porcelain=v2' }, {
  on_exit = function()
    P(d)
  end,
  on_stdout = function(_, data)
    if not data then return end
    if not d.count_staged then
      d = {
        count_staged = 0,
        count_unstaged = 0,
        count_untracked = 0,
      }
    end
    for _, line in ipairs(data) do
      if line == '' then return end
      -- handle line
      local header, value = line:match('# ([%w%.]+) (.+)')
      if header then
        if header == 'branch.head' then
          d.head = value
        elseif header == 'branch.upstream' then
          d.upstream = value
        elseif header == 'branch.ab' then
          local ahead, behind = value:match('+(%d+) -(%d+)')
          d.ahead = ahead
          d.behind = behind
        end
      else
        local kind, str = line:match('(.) (.+)')

        if kind == '1' then
          -- changed
          local mode_staged, mode_unstaged, _, _, _, _, _, _, _ =
          str:match('(.)(.) (....) (%d+) (%d+) (%d+) (%w+) (%w+) (.+)')
          if mode_staged ~= '.' then
            d.count_staged = d.count_staged + 1
          end
          if mode_unstaged ~= '.' then
            d.count_unstaged = d.count_unstaged + 1
          end
        elseif kind == '2' then
          -- renamed/copied
          local mode_staged, mode_unstaged, _, _, _, _, _, _, _ =
          str:match('(.)(.) (....) (%d+) (%d+) (%d+) (%w+) (%w+) (%a%d+) (.+)')
          if mode_staged ~= '.' then
            d.count_staged = d.count_staged + 1
          end
          if mode_unstaged ~= '.' then
            d.count_unstaged = d.count_unstaged + 1
          end
        elseif kind == 'u' then
          -- unmerged
          d.count_untracked = d.count_untracked + 1
        elseif kind == '?' then
          -- untracked
          d.count_untracked = d.count_untracked + 1
        end
      end
    end
  end,
})
]]
