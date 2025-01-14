return {
  'xvzc/chezmoi.nvim',
  cmd = 'Chezmoi',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('chezmoi').setup {
      -- your configurations
      edit = {
        watch = true,
        force = false,
      },
      notification = {
        on_open = true,
        on_apply = true,
        on_watch = false,
      },
      telescope = {
        select = { '<CR>' },
      },
    }
  end,
}
