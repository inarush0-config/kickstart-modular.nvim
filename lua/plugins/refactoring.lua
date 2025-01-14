return {
  'ThePrimeagen/refactoring.nvim',
  keys = {
    { '<leader>re', mode = 'x', desc = 'Refactor extract' },
    { '<leader>rv', mode = 'x', desc = 'Refactor extract var' },
    { '<leader>rb', mode = 'n', desc = 'Refactor extract block' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    local ok, refactoring = pcall(require, 'refactoring')
    if not ok then
      vim.notify('Failed to load refactoring.nvim', vim.log.levels.ERROR)
      return
    end

    -- Setup refactoring with an empty configuration table
    refactoring.setup {}

    -- Preserve your keymaps
    vim.keymap.set('x', '<leader>re', ':Refactor extract ', { desc = 'Refactor extract' })
    vim.keymap.set('x', '<leader>rv', ':Refactor extract_var ', { desc = 'Refactor extract var' })
    vim.keymap.set('n', '<leader>rb', ':Refactor extract_block', { desc = 'Refactor extract block' })
  end,
}
