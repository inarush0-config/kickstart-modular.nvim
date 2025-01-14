-- Plugin for displaying keybinding hints
return {
  'folke/which-key.nvim',
  event = 'VeryLazy', -- Load during idle time to reduce startup time
  opts = {
    preset = 'modern', -- Choose layout preset: 'classic', 'modern', 'helix'
    delay = function(ctx)
      return ctx.plugin and 0 or 200 -- Delay popup for keymaps (default: 200ms)
    end,
    notify = true, -- Show warnings for issues with mappings
    plugins = {
      marks = true, -- Show marks in the popup
      registers = true, -- Show registers in the popup
      spelling = {
        enabled = true, -- Show spelling suggestions in the popup
        suggestions = 20, -- Number of spelling suggestions to display
      },
      presets = {
        operators = true, -- Help for operators (e.g., `d`, `y`)
        motions = true, -- Help for motions
        text_objects = true, -- Help for text objects after an operator
        windows = true, -- Help for `<C-w>` window commands
        nav = true, -- Help for navigation commands
        z = true, -- Help for `z` prefixed commands (folds, spelling, etc.)
        g = true, -- Help for `g` prefixed commands
      },
    },
    win = {
      no_overlap = true, -- Prevent popup from overlapping with cursor
      padding = { 1, 2 }, -- Add padding around the popup
      title = true, -- Show a title for the popup
      title_pos = 'center', -- Position the title in the center
      zindex = 1000, -- Z-index for the popup
    },
    layout = {
      width = { min = 20 }, -- Minimum width for the columns
      spacing = 3, -- Spacing between columns
    },
    icons = {
      breadcrumb = '»', -- Symbol for breadcrumbs
      separator = '➜', -- Symbol between key and description
      group = '+', -- Symbol for groups
    },
    show_help = true, -- Show a help message in the command line
    show_keys = true, -- Show the currently pressed keys in the command line
    sort = { 'local', 'order', 'group', 'alphanum', 'mod' }, -- Sorting order for mappings
  },
  config = function(_, opts)
    local ok, which_key = pcall(require, 'which-key')
    if not ok then
      vim.notify('Failed to load which-key.nvim', vim.log.levels.ERROR)
      return
    end

    -- Initialize with options
    which_key.setup(opts)

    -- Register group descriptions using the new keymap spec
    which_key.add {
      { '<leader>b', group = 'Buffer' },
      { '<leader>c', group = 'Code' },
      { '<leader>d', group = 'Debug/Diagnostics' },
      { '<leader>f', group = 'Find/Format' },
      { '<leader>g', group = 'Git' },
      { '<leader>r', group = 'Rename/Refactor' },
      { '<leader>s', group = 'Search' },
      { '<leader>t', group = 'Toggle' },
      { '<leader>w', group = 'Workspace' },
    }

    -- Example: Add a mapping for buffer-local keymaps
    which_key.add {
      {
        '<leader>?',
        function()
          which_key.show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    }
  end,
}
