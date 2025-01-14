return {
  'stevearc/oil.nvim',
  cmd = 'Oil', -- Lazy-load with the Oil command
  keys = {
    { '-', desc = 'Open parent directory' }, -- Preserved your keymap
  },
  opts = {},
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- Optional dependency preserved
  config = function()
    local ok, oil = pcall(require, 'oil')
    if not ok then
      vim.notify('Failed to load oil.nvim', vim.log.levels.ERROR)
      return
    end

    -- Setup Oil with your original configuration
    oil.setup {
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
        ['<C-x>'] = { 'actions.select', opts = { vertical = true } },
      },
    }

    -- Reapply your keymap
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
