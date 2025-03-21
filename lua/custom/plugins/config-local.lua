vim.pack.add { 'https://github.com/klen/nvim-config-local' }
require('config-local').setup {
  config_files = { '.nvim.lua', '.nvimrc', '.nvim/local.vim', '.nvimrc.lua' },
  hashfile = vim.fn.stdpath 'data' .. '/config-local',
  autocommands_create = true,
  commands_create = true,
  silent = false,
  lookup_parents = true,
}
