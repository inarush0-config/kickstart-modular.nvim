-- Utility function for better keymap management
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

---------------------------
-- General Mappings
---------------------------
-- disable highlight on esc
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Disable Highlight' })

-- Quick save with Ctrl-s
map('n', '<C-s>', '<Cmd>write<CR>', { desc = 'Save for muscle memory' })

---------------------------
-- Diagnostic Navigation
---------------------------
map('n', '[d', function()
  vim.diagnostic.goto_prev { severity = { min = vim.diagnostic.severity.HINT } }
end, { desc = 'Go to previous diagnostic message' })

map('n', ']d', function()
  vim.diagnostic.goto_next { severity = { min = vim.diagnostic.severity.HINT } }
end, { desc = 'Go to next diagnostic message' })

map('n', '<leader>e', function()
  vim.diagnostic.open_float { source = true }
end, { desc = 'Show diagnostic error messages' })

map('n', '<leader>q', function()
  vim.diagnostic.setloclist { source = true }
end, { desc = 'Open diagnostic quickfix list' })

---------------------------
-- Window Navigation
---------------------------
for key, dir in pairs {
  h = 'left',
  j = 'lower',
  k = 'upper',
  l = 'right',
} do
  map('n', '<C-' .. key .. '>', '<C-w><C-' .. key .. '>', { desc = 'Move focus to the ' .. dir .. ' window' })
end
