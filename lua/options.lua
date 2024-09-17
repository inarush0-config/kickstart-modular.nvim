vim.opt.breakindent = true
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.inccommand = 'split'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.spell = true
vim.opt.spelllang = 'en_us'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.ttimeoutlen = 30
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.wo.wrap = false

vim.filetype.add {
  extension = {
    tf = 'terraform',
  },
}

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
