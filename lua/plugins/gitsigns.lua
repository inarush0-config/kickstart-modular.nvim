-- Git signs and hunk management plugin
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' }, -- Lazy-load on file read or creation
  opts = {
    signs = {
      add = { text = '+' }, -- Sign for added lines
      change = { text = '~' }, -- Sign for changed lines
      delete = { text = '_' }, -- Sign for deleted lines
      topdelete = { text = '‾' }, -- Sign for top-deleted lines
      changedelete = { text = '~' }, -- Sign for changed-deleted lines
      untracked = { text = '┆' }, -- Sign for untracked lines
    },
    signcolumn = true, -- Show signs in the sign column
    watch_gitdir = {
      interval = 1000, -- Refresh interval in ms
      follow_files = true, -- Follow file changes
    },
    attach_to_untracked = true, -- Attach signs to untracked files
    sign_priority = 5, -- Priority of git signs
    update_debounce = 100, -- Debounce time for updates
    max_file_length = 40000, -- Disable for files longer than this length
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']h', function()
        if vim.wo.diff then
          return ']h'
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Next hunk' })

      map('n', '[h', function()
        if vim.wo.diff then
          return '[h'
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return '<Ignore>'
      end, { expr = true, desc = 'Previous hunk' })

      -- Actions
      map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'Toggle blame line' })
      map('n', '<leader>tp', gs.preview_hunk, { desc = 'Preview hunk' })

      -- Text object
      map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'Select hunk' })
    end,

    current_line_blame = true, -- Enable blame for the current line
    current_line_blame_opts = {
      virt_text = true, -- Show blame text as virtual text
      virt_text_pos = 'eol', -- Position blame text at end of line
      delay = 1000, -- Delay before showing blame
      ignore_whitespace = true, -- Ignore whitespace changes in blame
    },
    preview_config = {
      border = 'rounded', -- Rounded border for hunk preview
      relative = 'cursor', -- Position relative to cursor
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false, -- Disable YADM integration
    },
  },
}
