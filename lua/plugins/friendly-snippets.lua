return {
  'rafamadriz/friendly-snippets',
  event = 'InsertEnter',
  dependencies = { 'L3MON4D3/LuaSnip' },
  config = function()
    if not pcall(require, 'luasnip') then
      vim.notify('Failed to load LuaSnip. friendly-snippets may not work.', vim.log.levels.WARN)
      return
    end
    require('luasnip.loaders.from_vscode').lazy_load()
  end,
}
