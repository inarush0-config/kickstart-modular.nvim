return {
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
      python = {
        'ruff_format',
        'ruff_organize_imports',
      },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
    },
  },
  config = function(_, opts)
    local ok, conform = pcall(require, 'conform')
    if not ok then
      vim.notify('Failed to load conform.nvim', vim.log.levels.ERROR)
      return
    end
    conform.setup(opts)
  end,
}
