return {
    'ellisonleao/gruvbox.nvim',
    lazy = false,
    priority = 900,
    config = function()
        vim.o.background = 'dark'
        vim.cmd.colorscheme 'gruvbox'
    end,
}
