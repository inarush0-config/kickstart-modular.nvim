-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      local gs = require 'gitsigns'
      gs.setup {
        current_line_blame = true,
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        require('which-key').register({
          t = {
            name = '[T]oggle',
            b = {
              function()
                gs.blame_line { full = true }
              end,
              'Toggle [F]ull Blame',
            },
            d = { gs.diffthis, 'Toggle Git [D]iff' },
            p = { gs.preview_hunk, 'Toggle Hunk [P]review' },
          },
        }, { prefix = '<leader>' }),
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
