return {
  'HiPhish/rainbow-delimiters.nvim',
  opts = {
    strategy = { 'global' },
  },
  config = function(_, opts)
    local ok, rainbow_delimiters = pcall(require, 'rainbow-delimiters')
    if not ok then
      vim.notify('Failed to load rainbow-delimiters.nvim', vim.log.levels.ERROR)
      return
    end

    rainbow_delimiters.setup(opts)
  end,
}
