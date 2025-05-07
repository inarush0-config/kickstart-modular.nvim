return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'modern',
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    notify = true,
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = true,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },
    win = {
      no_overlap = true,
      padding = { 1, 2 },
      title = true,
      title_pos = 'center',
      zindex = 1000,
    },
    layout = {
      width = { min = 20 },
      spacing = 3,
    },
    icons = {
      breadcrumb = '»',
      separator = '➜',
      group = '+',
    },
    show_help = true,
    show_keys = true,
    sort = { 'local', 'order', 'group', 'alphanum', 'mod' },
  },
  config = function(_, opts)
    local ok, which_key = pcall(require, 'which-key')
    if not ok then
      vim.notify('Failed to load which-key.nvim', vim.log.levels.ERROR)
      return
    end

    which_key.setup(opts)

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
