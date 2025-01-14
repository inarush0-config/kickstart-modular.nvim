-- Chezmoi plugin for managing dotfiles within Neovim
return {
  'xvzc/chezmoi.nvim',
  cmd = 'Chezmoi', -- Lazy-load when this command is called
  dependencies = { 'nvim-lua/plenary.nvim' }, -- Required dependency

  config = function()
    local success, chezmoi = pcall(require, 'chezmoi')
    if not success then
      vim.notify('Failed to load chezmoi.nvim', vim.log.levels.ERROR)
      return
    end

    chezmoi.setup {
      -- General settings
      edit = {
        watch = true, -- Watch for changes in dotfiles
        force = false, -- Do not overwrite changes without confirmation
      },
      notification = {
        on_open = true, -- Notify on opening dotfiles
        on_apply = true, -- Notify on applying changes
        on_watch = false, -- Do not notify on file watching
      },
      -- Telescope integration
      telescope = {
        select = { '<CR>' }, -- Key to confirm selection
      },
    }
  end,
}
