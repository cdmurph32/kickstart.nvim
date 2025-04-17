-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'vhyrro/luarocks.nvim',
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    opts = {
      rocks = { 'tiktoken_core' },
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
        copilot_node_command = vim.fn.expand '$HOME' .. '/.nvm/versions/node/v22/bin/node', -- Node.js version must be > 18.x
      }
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    dependencies = { 'nvim-cmp' },
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'main',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log wrapper
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    model = 'copilot:gpt-4',
    providers = {
      github_models = {
        disables = true,
      },
    },
    opts = {
      -- debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = 'float',
        relative = 'cursor',
        width = 1,
        height = 0.4,
        row = 1,
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  'tpope/vim-fugitive',
  'tpope/vim-abolish',
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
  vim.keymap.set('n', '<leader>n', ':Neotree filesystem reveal left<CR>'),
  vim.keymap.set({ 'n', 'v' }, '<leader>ccq', function()
    local select = require 'CopilotChat.select'
    local input = vim.fn.input 'Quick Chat: '
    if input ~= '' then
      require('CopilotChat').ask(input, {
        selection = function(source)
          return select.visual(source) or select.buffer(source)
        end,
      })
    end
  end, { desc = 'CopilotChat - Quick chat' }),
  vim.keymap.set('n', '<leader>cco', ':CopilotChatOpen'),
  vim.keymap.set('n', '<leader>ccp', function()
    local actions = require 'CopilotChat.actions'
    require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
  end, { desc = 'CopilotChat - Prompt actions' }),
}
