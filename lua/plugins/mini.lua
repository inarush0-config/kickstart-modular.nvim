return {
  {
    'echasnovski/mini.nvim',
    version = false,
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('mini.ai').setup {}
      require('mini.align').setup {}
      require('mini.comment').setup {}
      require('mini.indentscope').setup {}
      require('mini.surround').setup {}
      require('mini.move').setup {}
    end,
  },
}
