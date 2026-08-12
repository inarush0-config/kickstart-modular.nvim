return {
    'eandrju/cellular-automaton.nvim',
    cmd = 'CellularAutomaton',
    event = "VeryLazy",
    config = function()
        vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>', {
            desc = 'Start "make it rain" animation',
        })
    end,
}
