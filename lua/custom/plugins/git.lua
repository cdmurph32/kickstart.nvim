vim.pack.add {
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-abolish',
  'https://github.com/tpope/vim-rhubarb',
  'https://github.com/ruanyl/vim-gh-line',
}
vim.api.nvim_create_autocmd('User', {
  pattern = 'FugitiveIndex',
  callback = function()
    vim.cmd 'wincmd H'
    vim.api.nvim_win_set_width(0, 80)
    vim.wo.winfixwidth = true
  end,
})
