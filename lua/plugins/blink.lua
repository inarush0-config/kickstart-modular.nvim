-- Configuration for blink.cmp
return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets', -- Snippet source dependency
  version = '*', -- Use the latest version
  opts = {
    keymap = { preset = 'default' }, -- Keymap preset
    appearance = {
      use_nvim_cmp_as_default = true, -- Use nvim-cmp highlight groups
      nerd_font_variant = 'mono', -- Adjust icon alignment for Nerd Fonts
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' }, -- Default sources
    },
  },
  config = function(_, opts)
    local ok, blink = pcall(require, 'blink.cmp')
    if not ok then
      vim.notify('Failed to load blink.cmp', vim.log.levels.ERROR)
      return
    end

    -- Validate menu positioning if needed (cmdline_position no longer accessed directly)
    blink.setup(opts)
  end,
}
