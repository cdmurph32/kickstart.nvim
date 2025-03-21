vim.pack.add { 'https://github.com/nickjvandyke/opencode.nvim' }
vim.g.opencode_opts = {}
vim.o.autoread = true
local oc = require 'opencode'
vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() oc.ask('@this: ', { submit = true }) end, { desc = 'Ask opencode' })
vim.keymap.set({ 'n', 'x' }, '<leader>ox', function() oc.select() end, { desc = 'Opencode select action' })
vim.keymap.set({ 'n', 't' }, '<leader>oo', function()
  vim.fn.jobstart('pgrep -x ollama > /dev/null || ollama serve &', { detach = true })
  vim.defer_fn(function()
    vim.fn.jobstart({
      'curl', '-s', '-X', 'POST',
      'http://localhost:11434/api/generate',
      '-d', '{"model":"gemma4:26b-a4b-it-q4_K_M","keep_alive":"10m"}',
    }, { detach = true })
    oc.toggle()
  end, 1500)
end, { desc = 'Toggle opencode' })
