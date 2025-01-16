-- Set leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Check for Nerd Font support
vim.g.have_nerd_font = true

-- Enable module caching for faster startup
vim.loader.enable()

_G.map = function(mode, lhs, rhs, opts)
  -- Default options
  local options = { noremap = true, silent = true }

  -- If opts provided, merge them with default options
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end

  -- Extract description for which-key (if provided)
  local wk_opts = {}
  if opts and opts.desc then
    wk_opts.desc = opts.desc
  end

  -- Set the keymap
  vim.keymap.set(mode, lhs, rhs, options)

  -- Register with which-key
  local status_ok, which_key = pcall(require, 'which-key')
  if status_ok then
    which_key.add({ { [lhs] = wk_opts } }, { mode = mode })
  end
end

-- Load core configurations with error handling
local modules = { 'options', 'keymaps', 'bootstrap' }
for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify('Failed to load ' .. module .. ': ' .. err, vim.log.levels.WARN)
  end
end
