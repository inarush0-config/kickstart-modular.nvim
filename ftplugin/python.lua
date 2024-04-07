return {
  vim.keymap.set('n', '<F1>', require('dap-python').test_method, { desc = 'Debug: Test Method' }),
}
