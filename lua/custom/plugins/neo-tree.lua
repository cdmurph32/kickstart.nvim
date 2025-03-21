vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/nvim-neo-tree/neo-tree.nvim',
}
vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>', { desc = 'Reveal in neo-tree' })
