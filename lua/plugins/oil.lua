return {
  'stevearc/oil.nvim',
  cmd = 'Oil',
  keys = {
    { '-', desc = 'Open parent directory' },
  },
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local ok, oil = pcall(require, 'oil')
    if not ok then
      vim.notify('Failed to load oil.nvim', vim.log.levels.ERROR)
      return
    end

    oil.setup {
      watch_for_changes = true,
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-x>'] = { 'actions.select', opts = { vertical = true } },
      },
    }

    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
