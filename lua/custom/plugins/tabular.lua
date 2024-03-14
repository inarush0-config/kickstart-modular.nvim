return {
  'godlygeek/tabular',
  config = function()
    vim.keymap.set('v', '<leader>ft', ':Tabularize/|\\s*\\zs.\\{-}\\ze\\s*|/c1<CR>')
  end,
}
