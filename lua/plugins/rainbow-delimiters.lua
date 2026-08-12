return {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
    config = function()
        -- These are the plugin’s configuration variables
        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = require('rainbow-delimiters').strategy['global'],
            },
        }
    end,
}
