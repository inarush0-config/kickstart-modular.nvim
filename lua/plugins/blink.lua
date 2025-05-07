return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    keymap = { preset = 'default' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    sources = {
      default = { 'lsp', 'path', 'buffer' },
    },
  },
  config = function(_, opts)
    local ok, blink = pcall(require, 'blink.cmp')
    if not ok then
      vim.notify('Failed to load blink.cmp', vim.log.levels.ERROR)
      return
    end
    blink.setup(opts)
  end,
}
