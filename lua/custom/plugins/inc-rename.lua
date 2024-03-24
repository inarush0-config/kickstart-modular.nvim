return {
  'smjonas/inc-rename.nvim',
  config = function()
    require('inc_rename').setup()
    require('which-key').register({
      r = {
        name = '[R]ename',
        n = { ':IncRename ', 'IncRename' },
      },
    }, { prefix = '<leader>' })
  end,
}
