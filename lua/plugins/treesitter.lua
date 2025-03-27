return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
    config = function()
      -- Add this line to set the runtime path
      vim.opt.runtimepath:append(vim.fn.stdpath 'data' .. '/treesitter')

      local setup_safely = function(plugin, config)
        local status_ok, module = pcall(require, plugin)
        if not status_ok then
          vim.notify('Failed to load ' .. plugin, vim.log.levels.WARN)
          return
        end
        module.setup(config)
      end
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        parser_install_dir = vim.fn.stdpath 'data' .. '/treesitter',
        sync_install = false,
        ensure_installed = {
          'bash',
          'c',
          'dockerfile',
          'hcl',
          'html',
          'json',
          'lua',
          'markdown',
          'markdown_inline',
          'python',
          'vim',
          'vimdoc',
          'yaml',
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('treesitter-context').setup()
      vim.api.nvim_set_hl(0, 'TreesitterContext', { fg = 'fg', bg = 'bg' })
      vim.cmd 'hi TreesitterContextBottom gui=underline'
    end,
  },
  { 'nvim-treesitter/nvim-treesitter-textobjects', event = { 'BufReadPost', 'BufNewFile' } },
}
-- vim: ts=2 sts=2 sw=2 et
