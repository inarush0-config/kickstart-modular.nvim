-- disable highlight on esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Disable Highlight' })

-- diagnostics
vim.keymap.set('n', '[d', function()
  vim.diagnostic.goto_prev { severity = { min = vim.diagnostic.severity.HINT } }
end, { desc = 'Go to previous diagnostic message' })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.goto_next { severity = { min = vim.diagnostic.severity.HINT } }
end, { desc = 'Go to next diagnostic message' })

vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float { source = true }
end, { desc = 'Show diagnostic error messages' })

vim.keymap.set('n', '<leader>q', function()
  vim.diagnostic.setloclist { source = true }
end, { desc = 'Open diagnostic quickfix list' })

-- window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-s>', '<Cmd>write<CR>', { desc = 'Save for muscle memory' })
