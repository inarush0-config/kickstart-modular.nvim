return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = {
    { '<leader>sb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>', desc = 'Find in existing buffers' },
    { '<leader>sd', '<cmd>Telescope diagnostics<cr>', desc = 'Search diagnostics' },
    { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = 'Search files' },
    { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = 'Search by grep' },
    { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Search help' },
    { '<leader>sk', '<cmd>Telescope keymaps<cr>', desc = 'Search keymaps' },
    { '<leader>ss', '<cmd>Telescope builtin<cr>', desc = 'Select search' },
    { '<leader>sw', '<cmd>Telescope grep_string<cr>', desc = 'Search current word' },
    { '<leader>sz', '<cmd>Telescope chezmoi<cr>', desc = 'Search chezmoi files' },
    {
      '<leader>sn',
      function()
        require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
      end,
      desc = 'Search neovim config',
    },
  },
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      enabled = vim.fn.executable 'make' == 1,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local ok, telescope = pcall(require, 'telescope')
    if not ok then
      vim.notify('Failed to load telescope.nvim', vim.log.levels.ERROR)
      return
    end

    local actions = require 'telescope.actions'
    local action_layout = require 'telescope.actions.layout'

    telescope.setup {
      defaults = {
        cache_picker = {
          num_pickers = 5,
          limit_entries = 1000,
        },
        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-p>'] = action_layout.toggle_preview,
          },
        },
        file_previewer = require('telescope.previewers').vim_buffer_cat.new,
        grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
        vimgrep_arguments = {
          'rg',
          '--follow',
          '--hidden',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
          '--glob=!**/.git/*',
          '--glob=!**/.idea/*',
          '--glob=!**/.vscode/*',
          '--glob=!**/build/*',
          '--glob=!**/dist/*',
          '--glob=!**/yarn.lock',
          '--glob=!**/package-lock.json',
          '--glob=!**/.terraform/*',
        },
        file_ignore_patterns = {
          '%.git/',
          '%.terraform/',
          'node_modules/',
          '%.venv/',
          '%.pyc',
          '%.pytest_cache/',
          '%.DS_Store',
        },
        path_display = { truncate = 3 },
        dynamic_preview_title = true,
        results_title = false,
      },
      pickers = {
        find_files = {
          find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          previewer = false,
        },
        help_tags = {
          show_version = true,
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
      },
    }

    -- Load extensions safely
    local function load_extension(name)
      local ok = pcall(telescope.load_extension, name)
      if not ok then
        vim.notify('Failed to load telescope extension: ' .. name, vim.log.levels.WARN)
      end
    end

    load_extension 'fzf'
    load_extension 'ui-select'
    load_extension 'chezmoi'
  end,
}
