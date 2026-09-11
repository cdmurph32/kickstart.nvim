vim.pack.add { 'https://github.com/nickjvandyke/opencode.nvim' }
vim.g.opencode_opts = {
  server = {
    start = function() vim.cmd 'vsplit term://opencode --port --auto | wincmd p' end,
  },
}
vim.o.autoread = true
local oc = require 'opencode'
vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() oc.ask '@this: ' end, { desc = 'Ask opencode' })
vim.keymap.set({ 'n', 'x' }, '<leader>ox', function() oc.select() end, { desc = 'Opencode select action' })
vim.keymap.set({ 'n', 't' }, '<leader>oo', function() oc.command 'session.new' end, { desc = 'New opencode session' })
