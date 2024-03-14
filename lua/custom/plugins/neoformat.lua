return {
  'sbdchd/neoformat',
  config = function()
    local aug_id = vim.api.nvim_create_augroup('neoformat', { clear = true })
    vim.g.neoformat_enabled_markdown = { 'mdformat' }
    vim.api.nvim_create_autocmd('BufWritePost', {
      pattern = { '*.md' },
      command = 'Neoformat',
    })
  end,
}
