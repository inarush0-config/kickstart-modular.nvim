local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

-- Install lazy.nvim if not installed
if not vim.uv.fs_stat(lazypath) then
  vim.notify('Installing lazy.nvim...', vim.log.levels.INFO)
  local result = vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. result)
  end
end

local plugins_spec = {
  { import = 'plugins' },
  {
    import = 'plugins.work',
    cond = function()
      local work_dir = vim.fn.stdpath 'config' .. '/lua/plugins/work'
      return vim.fn.isdirectory(work_dir) == 1
    end,
  },
}

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup {
  spec = plugins_spec,
  defaults = {
    lazy = true,
    version = '*',
  },
  install = {
    colorscheme = { 'gruvbox' },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  ui = {
    border = 'rounded',
    icons = {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🔑',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
}
