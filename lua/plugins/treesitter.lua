return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'main',
    build = ':TSUpdate',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup()
      vim.api.nvim_set_hl(0, 'TreesitterContext', { fg = 'fg', bg = 'bg' })
      vim.cmd 'hi TreesitterContextBottom gui=underline'
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects'},
}
-- vim: ts=2 sts=2 sw=2 et
