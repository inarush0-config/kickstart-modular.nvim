return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
    vim.keymap.set('n', '<leader>ha', function()
      harpoon:list():append()
    end)
    vim.keymap.set('n', '<leader>hd', function()
      harpoon:list():remove()
    end)
    vim.keymap.set('n', '<leader>hc', function()
      harpoon:list():clear()
    end)
    vim.keymap.set('n', '<leader>hh', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    vim.keymap.set('n', '<leader>hp', function()
      harpoon:list():prev()
    end)
    vim.keymap.set('n', '<leader>hn', function()
      harpoon:list():next()
    end)
  end,
}
