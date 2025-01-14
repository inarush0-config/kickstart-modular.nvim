-- Provides a collection of ready-to-use code snippets
return {
  'rafamadriz/friendly-snippets',
  event = 'InsertEnter', -- Lazy-load when entering Insert mode
  dependencies = { 'L3MON4D3/LuaSnip' }, -- Ensure LuaSnip is loaded
  config = function()
    if not pcall(require, 'luasnip') then
      vim.notify('Failed to load LuaSnip. friendly-snippets may not work.', vim.log.levels.WARN)
      return
    end

    -- Load VSCode-style snippets
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}
