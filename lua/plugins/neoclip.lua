return {
  'AckslD/nvim-neoclip.lua',
  cmd = 'Telescope',
  keys = {
    { '<leader>sy', desc = 'Search YankRegisters' },
  },
  dependencies = {
    { 'kkharji/sqlite.lua', module = 'sqlite' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('neoclip').setup()
    local telescope = require 'telescope'
    telescope.load_extension 'neoclip'
    vim.keymap.set('n', '<leader>sy', telescope.extensions.neoclip.default, { desc = 'Search YankRegisters' })
  end,
}
