return {
  {
    'nvim-mini/mini.nvim',
    version = false,
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      local ai = require 'mini.ai'
      ai.setup {
        custom_textobjects = {
          f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' },
          c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' },
          o = ai.gen_spec.treesitter {
            a = { '@block.outer', '@conditional.outer', '@loop.outer' },
            i = { '@block.inner', '@conditional.inner', '@loop.inner' },
          },
        },
      }
      require('mini.align').setup {}
      require('mini.comment').setup {}
      require('mini.indentscope').setup {}
      require('mini.surround').setup {}
      require('mini.move').setup {}
    end,
  },
}
