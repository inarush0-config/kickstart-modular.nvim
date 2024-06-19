return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        vimgrep_arguments = {
          'rg',
          '--follow', -- Follow symbolic links
          '--hidden', -- Search for hidden files
          '--no-heading', -- Don't group matches by each file
          '--with-filename', -- Print the file path with the matched lines
          '--line-number', -- Show line numbers
          '--column', -- Show column numbers
          '--smart-case', -- Smart case search

          -- Exclude some patterns from search
          '--glob=!**/.git/*',
          '--glob=!**/.idea/*',
          '--glob=!**/.vscode/*',
          '--glob=!**/build/*',
          '--glob=!**/dist/*',
          '--glob=!**/yarn.lock',
          '--glob=!**/package-lock.json',
        },
        file_ignore_patterns = {
          '.DS_Store',
          '.git/',
          'node_modules/',
          '.venv/',
          '.terraform/',
          '.pyc',
          '.pytest_cache/',
        },
      },
      pickers = {
        find_files = {
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'chezmoi')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    local telescope = require 'telescope'

    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = 'Find in existing buffers' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = 'Search diagnostics' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = 'Search files' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by grep' })
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = 'Search help' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = 'Search keymaps' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = 'Select search' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = 'Search current word' })
    vim.keymap.set('n', '<leader>sz', telescope.extensions.chezmoi.find_files, { desc = 'Search chezmoi files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = 'Search neovim config' })
  end,
}
