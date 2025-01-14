return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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
        on_attach = function()
          vim.keymap.set('n', '<leader>tb', function()
            gs.blame_line { full = true }
          end, { desc = 'Toggle full blame' })
          vim.keymap.set('n', '<leader>td', gs.diffthis, { desc = 'Toggle git diff' })
          vim.keymap.set('n', '<leader>tp', gs.preview_hunk, { desc = 'Toggle hunk preview' })
        end,
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
