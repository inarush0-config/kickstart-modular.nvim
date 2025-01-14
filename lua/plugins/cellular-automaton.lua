-- Cellular Automaton plugin for animations in Neovim
return {
  'eandrju/cellular-automaton.nvim',
  cmd = 'CellularAutomaton', -- Load plugin only when this command is called
  config = function()
    -- Keymap to trigger "make it rain" animation
    vim.keymap.set('n', '<leader>fml', '<cmd>CellularAutomaton make_it_rain<CR>', {
      desc = 'Start "make it rain" animation',
    })
  end,
}
