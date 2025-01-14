-- Code formatting plugin with multi-language support
return {
  'stevearc/conform.nvim',
  event = { 'BufReadPost', 'BufNewFile' }, -- Lazy-load on file read or creation
  opts = {
    notify_on_error = true, -- Notify if an error occurs during formatting
    format_on_save = {
      timeout_ms = 2000, -- Timeout for formatting
      lsp_fallback = true, -- Use LSP formatter if no formatter is configured
    },
    formatters_by_ft = {
      json = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      toml = { 'taplo' },
      typescript = { 'prettier' },
      python = {
        "ruff_fix",
        "ruff_format",
        "ruff_organize_imports",
      }
    },
  },
  config = function(_, opts)
    local ok, conform = pcall(require, 'conform')
    if not ok then
      vim.notify('Failed to load conform.nvim', vim.log.levels.ERROR)
      return
    end

    -- Load configuration
    conform.setup(opts)

    -- Optional: Add custom file type formatting (uncomment to use)
    -- opts.formatters_by_ft.yaml = { 'yamlfmt' }
  end,
}
