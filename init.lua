-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Check for Nerd Font support
vim.g.have_nerd_font = true

-- Enable module caching for faster startup
vim.loader.enable()

-- Load core configurations with error handling
local modules = { 'options', 'keymaps', 'bootstrap' }
for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify('Failed to load ' .. module .. ': ' .. err, vim.log.levels.WARN)
  end
end

