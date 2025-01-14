return {
  'pmizio/typescript-tools.nvim',
  ft = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact' }, -- Only load for TS/JS files
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {},
  config = function()
    require('typescript-tools').setup {
      settings = {
        expose_as_code_action = 'all',
      },
    }
  end,
}
