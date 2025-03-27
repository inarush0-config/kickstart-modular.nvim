return {
  'christoomey/vim-tmux-navigator',
  lazy = false,
  cmd = {
    'TmuxNavigateLeft',
    'TmuxNavigateDown',
    'TmuxNavigateUp',
    'TmuxNavigateRight',
    'TmuxNavigatePrevious',
  },
  keys = {
    { '<c-h>', '<cmd>TmuxNavigateLeft<cr>' },
    { '<c-j>', '<cmd>TmuxNavigateDown<cr>' },
    { '<c-k>', '<cmd>TmuxNavigateUp<cr>' },
    { '<c-l>', '<cmd>TmuxNavigateRight<cr>' },
    { '<c-\\>', '<cmd>TmuxNavigatePrevious<cr>' },
  },
  config = function()
    vim.g.tmux_navigator_no_mappings = 1
    vim.g.tmux_navigator_preserve_zoom = 1
    vim.g.tmux_navigator_disable_when_zoomed = 1

    local function tmux_command(command)
      vim.fn.system('tmux ' .. command)
    end

    local function set_is_vim()
      tmux_command 'set-option -p @is_vim yes'
    end

    local function unset_is_vim()
      tmux_command 'set-option -p -u @is_vim'
    end

    local tmux_navigator_group = vim.api.nvim_create_augroup('tmux_navigator_is_vim', { clear = true })

    vim.api.nvim_create_autocmd('VimEnter', {
      group = tmux_navigator_group,
      callback = set_is_vim,
    })

    vim.api.nvim_create_autocmd('VimLeave', {
      group = tmux_navigator_group,
      callback = unset_is_vim,
    })

    if vim.fn.exists '##VimSuspend' == 1 then
      vim.api.nvim_create_autocmd('VimSuspend', {
        group = tmux_navigator_group,
        callback = unset_is_vim,
      })

      vim.api.nvim_create_autocmd('VimResume', {
        group = tmux_navigator_group,
        callback = set_is_vim,
      })
    end
  end,
}
