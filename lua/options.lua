-- Editor UI
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers for better navigation
vim.opt.signcolumn = 'yes' -- Always show the sign column
vim.opt.cursorline = true -- Highlight the current line
vim.opt.colorcolumn = '80' -- Highlight column 80 for line length indicator
vim.opt.showmode = false -- Don't show mode (statusline handles it)
vim.opt.termguicolors = true -- Enable true color support

-- Editing
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 4 -- Number of spaces to use for (auto)indent
vim.opt.tabstop = 4 -- Number of spaces per tab
vim.opt.spelllang = 'en_us' -- Set spell check language to US English
vim.opt.spell = true -- Enable spell check
vim.opt.breakindent = true -- Maintain indentation when wrapping lines

-- Search
vim.opt.ignorecase = true -- Case insensitive searching
vim.opt.smartcase = true -- Case-sensitive if search contains uppercase
vim.opt.hlsearch = true -- Highlight search matches
vim.opt.inccommand = 'split' -- Live preview of search and replace

-- Window Management
vim.opt.splitbelow = true -- Horizontal splits open below
vim.opt.splitright = true -- Vertical splits open to the right
vim.opt.scrolloff = 999 -- Keep the cursor centered on the screen
vim.wo.wrap = false -- Disable line wrapping

-- File Management
vim.opt.undofile = true -- Save undo history to file
vim.opt.updatetime = 250 -- Faster update time for plugins and events

-- System Integration
vim.opt.mouse = 'a' -- Enable mouse in all modes
vim.opt.timeoutlen = 300 -- Timeout for mapped sequences
vim.opt.ttimeoutlen = 30 -- Timeout for key codes

-- Visual Helpers
vim.opt.list = true -- Show hidden characters
vim.opt.listchars = { -- Define how hidden characters are displayed
  tab = '» ',
  trail = '·',
  nbsp = '␣',
  extends = '›',
  precedes = '‹',
}

-- Enable folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- Start with all folds open
vim.opt.foldlevel = 99

-- Only fold more than 2 lines
vim.opt.foldminlines = 2

-- Prevent folded lines from having their background overwritten
vim.opt.highlight:append {
  Folded = { bg = 'NONE' },
}

-- Filetype Associations
vim.filetype.add {
  extension = {
    tf = 'terraform',
    tfvars = 'terraform',
    tfstate = 'json',
    hcl = 'hcl',
    cypher = 'cypher',
    yaml = 'yaml',
    yml = 'yaml',
    conf = 'dosini',
  },
  filename = {
    ['terraform.tfstate'] = 'json',
    ['.terraform.lock.hcl'] = 'hcl',
  },
  pattern = {
    ['*.ya?ml'] = 'yaml',
  },
}

-- Autocommands
-- Highlight text on yank
local yankHighlight = vim.api.nvim_create_augroup('highlight-yank', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = yankHighlight,
  desc = 'Highlight when yanking text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Terraform-specific settings
local terraformGroup = vim.api.nvim_create_augroup('terraform-settings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = terraformGroup,
  pattern = 'terraform',
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

-- yaml schema info command
vim.api.nvim_create_user_command('YamlSchemaInfo', function()
  local clients = vim.lsp.get_active_clients { bufnr = 0 }
  for _, client in pairs(clients) do
    if client.name == 'yamlls' then
      local schema = client.config.settings.yaml.schemas[vim.api.nvim_buf_get_name(0)]
      if schema then
        print('Current schema: ' .. schema)
      else
        print 'No schema applied to this file'
      end
      return
    end
  end
  print 'YAML language server not attached to this buffer'
end, {})
