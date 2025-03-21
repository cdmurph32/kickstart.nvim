vim.pack.add {
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/greggh/claude-code.nvim',
}
require('claude-code').setup {
  refresh = {
    enable = true,
    updatetime = 100,
    timer_interval = 1000,
    show_notifications = true,
  },
  git = { use_git_root = true },
  window = {
    position = 'vertical',
    split_ratio = 0.3,
    enter_insert = true,
  },
  keymaps = {
    toggle = {
      normal = '<leader>cc',
    },
  },
}
