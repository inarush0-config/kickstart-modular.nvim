-- Automatically pairs matching characters (e.g., (), {}, "", '')
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup()
  end,
}
