return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        json = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        toml = { 'taplo' },
        typescript = { 'prettier' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
