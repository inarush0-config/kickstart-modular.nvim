return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  opts = {
    cmdline = {
      enabled = true,
      view = 'cmdline_popup',
      format = {
        cmdline = { icon = '>' },
        search_down = { icon = '🔍⌄' },
        search_up = { icon = '🔍⌃' },
        filter = { icon = '$' },
        lua = { icon = '☾' },
        help = { icon = '?' },
      },
    },
    messages = {
      enabled = true,
      view = 'mini',
      view_error = 'mini',
      view_warn = 'mini',
      view_history = 'messages',
      view_search = 'virtualtext',
      view_recording = 'notify',
    },
    lsp = {
      -- Neovim 0.12 handles LSP progress natively; Noice's handler causes spam
      progress = {
        enabled = false,
      },
      override = {
        ['cmp.entry.get_documentation'] = true,
      },
      hover = {
        enabled = true,
      },
      signature = {
        enabled = true,
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
    routes = {
      {
        view = 'notify',
        filter = { event = 'msg_showmode' },
      },
    },
  },
  config = function(_, opts)
    local ok, noice = pcall(require, 'noice')
    if not ok then
      vim.notify('Failed to load noice.nvim', vim.log.levels.ERROR)
      return
    end
    noice.setup(opts)
  end,
}
