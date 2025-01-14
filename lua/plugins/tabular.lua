return {
  'godlygeek/tabular',
  cmd = 'Tabularize', -- Lazy-load with the Tabularize command
  keys = {
    { '<leader>ft', ':Tabularize/|\\s*\\zs.\\{-}\\ze\\s*|/c1<CR>', mode = 'v', desc = 'Align table' },
  },
  config = function()
    if not pcall(require, 'tabular') then
      vim.notify('Failed to load tabular.nvim', vim.log.levels.ERROR)
    end
  end,
}
