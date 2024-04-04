return {
  'wet-sandwich/hyper.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('which-key').register({
      h = {
        name = '[H]yper',
        y = { require('hyper.view').show, '[H]yper' },
      },
    }, { prefix = '<leader>' })
  end,
}
