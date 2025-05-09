return {
  'cbochs/grapple.nvim',
  opts = {
    scope = 'git',
  },
  event = { 'BufReadPost', 'BufNewFile' },
  cmd = 'Grapple',
  keys = {
    { '<leader>m', '<cmd>Grapple toggle<cr>', desc = 'Grapple toggle tag' },
    { '<leader>k', '<cmd>Grapple toggle_tags<cr>', desc = 'Grapple toggle tags' },
    { '<leader>K', '<cmd>Grapple toggle_scopes<cr>', desc = 'Grapple toggle scopes' },
    { '<leader>j', '<cmd>Grapple cycle forward<cr>', desc = 'Grapple cycle forward' },
    { '<leader>J', '<cmd>Grapple cycle backward<cr>', desc = 'Grapple cycle backward' },
    { '<leader>1', '<cmd>Grapple select index=1<cr>', desc = 'Grapple select 1' },
    { '<leader>2', '<cmd>Grapple select index=2<cr>', desc = 'Grapple select 2' },
    { '<leader>3', '<cmd>Grapple select index=3<cr>', desc = 'Grapple select 3' },
    { '<leader>4', '<cmd>Grapple select index=4<cr>', desc = 'Grapple select 4' },
  },
  config = function(_, opts)
    local ok, grapple = pcall(require, 'grapple')
    if not ok then
      vim.notify('Failed to load grapple.nvim', vim.log.levels.ERROR)
      return
    end
    grapple.setup(opts)
  end,
}
