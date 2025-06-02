local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

map('n', 's', '<Nop>') -- disable 's' in favor of mini.surround

map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Disable Highlight' })

map('n', '<C-s>', '<Cmd>write<CR>', { desc = 'Save for muscle memory' })

map('n', '[d', function()
  vim.diagnostic.jump { count = 1, float = true, severity = { min = vim.diagnostic.severity.HINT } }
end, { desc = 'Go to previous diagnostic message' })

map('n', ']d', function()
  vim.diagnostic.jump { count = -1, float = true, severity = { min = vim.diagnostic.severity.HINT } }
end, { desc = 'Go to next diagnostic message' })

map('n', '<leader>e', function()
  vim.diagnostic.open_float { source = true }
end, { desc = 'Show diagnostic error messages' })

map('n', '<leader>q', function()
  vim.diagnostic.setloclist { source = true }
end, { desc = 'Open diagnostic quickfix list' })
