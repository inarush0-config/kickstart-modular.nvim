return {
  'wintermute-cell/gitignore.nvim',
  cmd = 'Gitignore',
  keys = {
    {
      '<leader>gi',
      function()
        vim.cmd 'Gitignore'
      end,
      desc = 'Open Gitignore popup',
    },
  },
  config = function()
    if not pcall(require, 'gitignore') then
      vim.notify('Failed to load gitignore.nvim', vim.log.levels.ERROR)
      return
    end
  end,
}
