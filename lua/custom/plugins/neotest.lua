vim.pack.add {
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/antoinemadec/FixCursorHold.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/mrcjkb/rustaceanvim',
  'https://github.com/marilari88/neotest-vitest',
  'https://github.com/nvim-neotest/neotest',
}
local neotest = require 'neotest'
---@diagnostic disable-next-line: missing-fields
neotest.setup {
  adapters = {
    require 'rustaceanvim.neotest',
    require 'neotest-vitest',
  },
}
local map = vim.keymap.set
map('n', '<leader>tt', function() neotest.run.run() end, { desc = 'Run nearest test' })
map('n', '<leader>tf', function() neotest.run.run(vim.fn.expand '%') end, { desc = 'Run current file' })
---@diagnostic disable-next-line: missing-fields
map('n', '<leader>td', function() neotest.run.run { strategy = 'dap' } end, { desc = 'Run with debugger' })
map('n', '<leader>to', function() neotest.output.open() end, { desc = 'Open output' })
