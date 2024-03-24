-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of help_tags options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
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
      local whichkey = require 'which-key'

      whichkey.register({
        s = {
          name = '[S]earch',
          b = { builtin.buffers, '[ ] Find existing buffers' },
          d = { builtin.diagnostics, '[S]earch [D]iagnostics' },
          f = { builtin.find_files, '[S]earch [F]iles' },
          g = { builtin.live_grep, '[S]earch by [G]rep' },
          h = { builtin.help_tags, '[S]earch [H]elp' },
          k = { builtin.keymaps, '[S]earch [K]eymaps' },
          r = { builtin.resume, '[S]earch [R]esume' },
          s = { builtin.builtin, '[S]earch [S]elect Telescope' },
          w = { builtin.grep_string, '[S]earch current [W]ord' },
          z = { telescope.extensions.chezmoi.find_files, 'Che[Z]moi' },
          n = {
            function()
              builtin.find_files { cwd = vim.fn.stdpath 'config' }
            end,
            '[S]earch [N]eovim files',
          },
          ['.'] = { builtin.oldfiles, '[S]earch Recent Files ("." for repeat)' },
          ['/'] = {
            function()
              builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
              }
            end,
            '[S]earch [/] in Open Files',
          },
        },
      }, { prefix = '<leader>' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
