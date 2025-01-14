return {
  'ellisonleao/gruvbox.nvim',
  event = 'VimEnter',
  priority = 1000,
  config = function()
    vim.o.background = 'dark'
    vim.cmd.colorscheme 'gruvbox'
  end,
}
