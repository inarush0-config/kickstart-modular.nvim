return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash',
          'c',
          'dockerfile',
          'hcl',
          'html',
          'json',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'vim',
          'vimdoc',
          'yaml',
        },

        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('treesitter-context').setup()
      vim.api.nvim_set_hl(0, 'TreesitterContext', { fg = 'fg', bg = 'bg' })
      vim.cmd 'hi TreesitterContextBottom gui=underline'
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
}
-- vim: ts=2 sts=2 sw=2 et
