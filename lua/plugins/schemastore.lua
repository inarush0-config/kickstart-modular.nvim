return {
  'b0o/schemastore.nvim',
  config = function()
    if not pcall(require, 'schemastore') then
      vim.notify('Failed to load schemastore.nvim', vim.log.levels.ERROR)
      return
    end
    -- Additional integration with LSP can be added in other configurations.
  end,
}
