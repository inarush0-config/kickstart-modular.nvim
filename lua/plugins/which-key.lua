return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    vim.keymap.del('n', 'gc')
    require('which-key').setup()
  end,
}
