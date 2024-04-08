return {
  vim.keymap.set('n', '<F6>', require('dap-python').test_method, { desc = 'Debug: Test Method' }),
}
