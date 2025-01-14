return {
  'sitiom/nvim-numbertoggle',
  event = { 'BufReadPost', 'BufNewFile' }, -- Lazy-load on file events
  config = function()
    if not pcall(require, 'numbertoggle') then
      vim.notify('Failed to load nvim-numbertoggle', vim.log.levels.ERROR)
    end
  end,
}
