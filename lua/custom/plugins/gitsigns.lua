-- gitsigns is installed by init.lua; just add extra keymaps here
local gs = require 'gitsigns'
vim.keymap.set('n', ']h', function() gs.nav_hunk 'next' end, { desc = 'Next hunk' })
vim.keymap.set('n', '[h', function() gs.nav_hunk 'prev' end, { desc = 'Prev hunk' })
vim.keymap.set('n', ']H', function() gs.nav_hunk('next', { target = 'unstaged' }) end, { desc = 'Next unstaged hunk' })
vim.keymap.set('n', '[H', function() gs.nav_hunk('prev', { target = 'unstaged' }) end, { desc = 'Prev unstaged hunk' })
