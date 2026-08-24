return {
    'saghen/blink.cmp',
    lazy = false,
    dependencies = {
        'rafamadriz/friendly-snippets',
        'folke/lazydev.nvim',
    },
    version = '*',
    opts = {
        keymap = { preset = 'default' },
        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'mono',
        },
        sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                lazydev = {
                    name = 'LazyDev',
                    module = 'lazydev.integrations.blink',
                    score_offset = 100,
                },
            },
        },
    },
    config = function(_, opts)
        local ok, blink = pcall(require, 'blink.cmp')
        if not ok then
            vim.notify('Failed to load blink.cmp', vim.log.levels.ERROR)
            return
        end
        blink.setup(opts)
    end,
}
