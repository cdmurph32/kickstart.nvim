vim.pack.add {
  'https://github.com/mrcjkb/rustaceanvim',
  'https://github.com/mrjones2014/codesettings.nvim',
}

require('codesettings').setup {}

vim.lsp.config('rust-analyzer', {
  before_init = function(_, config)
    require('codesettings').with_local_settings(config.name, config)
  end,
})
