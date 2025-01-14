-- Plugin for managing .gitignore files
return {
  'wintermute-cell/gitignore.nvim',
  cmd = 'Gitignore', -- Lazy-load when the Gitignore command is used
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
    -- Additional configuration can be added here if needed
  end,
}
