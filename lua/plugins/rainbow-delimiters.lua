return {
  'HiPhish/rainbow-delimiters.nvim',
  opts = {
    strategy = { 'global' }, -- Example: Apply globally, configurable if needed
  },
  config = function(_, opts)
    local ok, rainbow_delimiters = pcall(require, 'rainbow-delimiters')
    if not ok then
      vim.notify('Failed to load rainbow-delimiters.nvim', vim.log.levels.ERROR)
      return
    end

    -- Setup rainbow-delimiters with your provided options
    rainbow_delimiters.setup(opts)
  end,
}
