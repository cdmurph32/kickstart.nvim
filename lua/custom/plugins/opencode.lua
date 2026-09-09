vim.pack.add { 'https://github.com/nickjvandyke/opencode.nvim' }
vim.g.opencode_opts = {}
vim.o.autoread = true
local oc = require 'opencode'
vim.keymap.set({ 'n', 'x' }, '<leader>oa', function() oc.ask('@this: ', { submit = true }) end, { desc = 'Ask opencode' })
vim.keymap.set({ 'n', 'x' }, '<leader>ox', function() oc.select() end, { desc = 'Opencode select action' })
vim.keymap.set({ 'n', 't' }, '<leader>oo', function() oc.toggle() end, { desc = 'Toggle opencode' })
