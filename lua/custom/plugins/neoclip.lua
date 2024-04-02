return {
  'AckslD/nvim-neoclip.lua',
  requires = {
    { 'kkharji/sqlite.lua', module = 'sqlite' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('neoclip').setup()
    local telescope = require 'telescope'
    telescope.load_extension 'neoclip'
    require('which-key').register({
      s = {
        y = { telescope.extensions.neoclip.default, '[S]earch [Y]ankRegisters' },
      },
    }, { prefix = '<leader>' })
  end,
}
