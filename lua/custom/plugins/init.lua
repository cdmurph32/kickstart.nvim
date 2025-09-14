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
    'giuxtaposition/blink-cmp-copilot',
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
    opts = {
      -- debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = 'vertical',
        relative = 'editor',
        width = 0.4,
        height = 1,
        row = 0,
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  'tpope/vim-fugitive',
  'tpope/vim-abolish',
  'tpope/vim-rhubarb', -- Only for GitHub. For custom Git servers, use vim-gf or configure a handler.
  'ruanyl/vim-gh-line', -- Supports GBrowse-like functionality for GitHub and custom Git servers.
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
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
  {
    'klen/nvim-config-local',
    opts = {
      config_files = { '.nvim.lua', '.nvimrc', '.nvim/local.vim', '.nvimrc.lua' }, -- Files to look for in your repo
      hashfile = vim.fn.stdpath 'data' .. '/config-local', -- Where to store hashes for trusted files
      autocommands_create = true, -- Create autocommands (recommended)
      commands_create = true, -- Create commands (ConfigLocalSource, ConfigLocalEdit, etc.)
      silent = false, -- Show notifications when loading local config
      lookup_parents = true, -- Lookup config files in parent directories
    },
  },
  {
    'mxsdev/nvim-dap-vscode-js',
    dependencies = { 'mfussenegger/nvim-dap' },
    event = 'VeryLazy', -- or remove event to always load
    config = function()
      require('dap-vscode-js').setup {
        debugger_path = vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter',
        debugger_cmd = { 'node', vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js' },
      }
    end,
  },
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'mrcjkb/rustaceanvim',
      'nvim-neotest/neotest-jest',
      'marilari88/neotest-vitest',
    },
    -- Configure neotest to use rustaceanvim for Rust
    config = function()
      local neotest = require 'neotest'
      neotest.setup {
        adapters = {
          require 'rustaceanvim.neotest',
          require 'neotest-jest',
          require 'neotest-vitest',
        },
      }
      -- Set up keybindings
      local map = vim.keymap.set
      --local opts = { noremap = true, silent = true }

      map('n', '<leader>tt', function()
        neotest.run.run()
      end, { desc = 'Run nearest test' }) -- Run nearest test
      map('n', '<leader>tf', function()
        neotest.run.run(vim.fn.expand '%')
      end, { desc = 'Run current file' })
      map('n', '<leader>td', function()
        neotest.run.run { strategy = 'dap' }
      end, { desc = 'Run with debugger' })
      map('n', '<leader>to', function()
        neotest.output.open()
      end, { desc = 'Open output' })
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
  vim.api.nvim_create_user_command('CopilotEnableSuggestions', function()
    require('copilot').setup {
      suggestion = { enabled = true },
      panel = { enabled = false },
      copilot_node_command = vim.fn.expand '$HOME' .. '/.nvm/versions/node/v22/bin/node',
    }
    vim.notify('Copilot suggestions enabled', vim.log.levels.INFO)
  end, {}),
  vim.api.nvim_create_user_command('CopilotDisableSuggestions', function()
    require('copilot').setup {
      suggestion = { enabled = false },
      panel = { enabled = false },
      copilot_node_command = vim.fn.expand '$HOME' .. '/.nvm/versions/node/v22/bin/node',
    }
    vim.notify('Copilot suggestions disabled', vim.log.levels.INFO)
  end, {}),
}
