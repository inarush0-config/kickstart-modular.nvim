return {
  'xvzc/chezmoi.nvim',
  cmd = 'Chezmoi',
  dependencies = { 'nvim-lua/plenary.nvim' },

  config = function()
    local success, chezmoi = pcall(require, 'chezmoi')
    if not success then
      vim.notify('Failed to load chezmoi.nvim', vim.log.levels.ERROR)
      return
    end

    chezmoi.setup {
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
