return {
  'chrisgrieser/nvim-early-retirement',
  event = 'VeryLazy',
  opts = {
    notificationOnAutoClose = true,
    retirementAgeMins = 10,
    ignoreAltFile = false,
    minimumBufferCount = 2,
  },
  config = function(_, opts)
    local ok, early_retirement = pcall(require, 'early-retirement')
    if not ok then
      vim.notify('Failed to load nvim-early-retirement', vim.log.levels.ERROR)
      return
    end
    early_retirement.setup(opts)
  end,
}
