vim.pack.add { 'https://github.com/iamcco/markdown-preview.nvim' }

vim.api.nvim_create_autocmd('User', {
  pattern = 'PackChanged',
  callback = function(ev)
    local data = ev.data
    if data.spec.name == 'markdown-preview.nvim' and data.kind ~= 'delete' then
      local app_dir = data.path .. '/app'
      vim.system({ 'sh', 'install.sh' }, { cwd = app_dir }, function(res)
        if res.code ~= 0 then
          vim.schedule(function()
            vim.notify('markdown-preview.nvim install.sh failed: ' .. (res.stderr or ''), vim.log.levels.ERROR)
          end)
        end
      end)
    end
  end,
})
