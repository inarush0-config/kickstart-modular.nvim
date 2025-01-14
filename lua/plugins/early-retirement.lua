-- Automatically closes inactive buffers
return {
  'chrisgrieser/nvim-early-retirement',
  event = 'VeryLazy', -- Lazy-load during idle time to optimize performance
  opts = {
    notificationOnAutoClose = true, -- Notify when a buffer is auto-closed
    retirementAgeMins = 10, -- Time (in minutes) before a buffer is considered inactive
    ignoreAltFile = false, -- Exclude alternate buffers from being closed
    minimumBufferCount = 2, -- Keep at least 2 buffers open
  },
  config = function(_, opts)
    local ok, early_retirement = pcall(require, 'early-retirement')
    if not ok then
      vim.notify('Failed to load nvim-early-retirement', vim.log.levels.ERROR)
      return
    end

    -- Setup early-retirement with options
    early_retirement.setup(opts)
  end,
}
