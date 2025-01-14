-- Inline rename plugin configuration
return {
  'smjonas/inc-rename.nvim',
  keys = {
    {
      '<leader>rn',
      function()
        return ':IncRename ' .. vim.fn.expand '<cword>'
      end,
      expr = true,
      desc = 'Rename symbol (inline)',
    },
  },
  opts = {}, -- Preserved any existing options (none provided in original)
  config = function(_, opts)
    local ok, inc_rename = pcall(require, 'inc_rename')
    if not ok then
      vim.notify('Failed to load inc-rename.nvim', vim.log.levels.ERROR)
      return
    end

    -- Setup inc-rename with provided options
    inc_rename.setup(opts)
  end,
}
