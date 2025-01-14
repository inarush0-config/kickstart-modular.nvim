return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  keys = {
    { '<C-e>', '<cmd>Neotree filesystem reveal right toggle<cr>', desc = 'Toggle NeoTree' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  init = function()
    -- Unless you are still migrating, remove the deprecated commands
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  config = function()
    local function copy_path(state)
      local node = state.tree:get_node()
      local filepath = node:get_id()
      local filename = node.name
      local modify = vim.fn.fnamemodify

      local results = {
        filepath,
        modify(filepath, ':.'),
        modify(filepath, ':~'),
        filename,
        modify(filename, ':r'),
        modify(filename, ':e'),
      }

      vim.ui.select({
        '1. Absolute path: ' .. results[1],
        '2. Path relative to CWD: ' .. results[2],
        '3. Path relative to HOME: ' .. results[3],
        '4. Filename: ' .. results[4],
        '5. Filename without extension: ' .. results[5],
        '6. Extension of the filename: ' .. results[6],
      }, { prompt = 'Choose to copy to clipboard:' }, function(choice)
        if choice then
          local i = tonumber(choice:sub(1, 1))
          if i then
            local result = results[i]
            vim.fn.setreg('"', result)
            vim.notify('Copied: ' .. result)
          end
        end
      end)
    end

    require('neo-tree').setup {
      close_if_last_window = true,
      sources = {
        'filesystem',
        'buffers',
        'git_status',
        'document_symbols',
      },
      source_selector = {
        winbar = true,
        content_layout = 'center',
        sources = {
          { source = 'filesystem' },
          { source = 'buffers' },
          { source = 'git_status' },
          { source = 'document_symbols' },
        },
      },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            '.git',
            'node_modules',
            '.terraform',
          },
          never_show = {
            '.DS_Store',
            'thumbs.db',
          },
        },
      },
      window = {
        position = 'right',
        mappings = {
          ['Y'] = copy_path,
          ['<space>'] = false, -- disable space mapping
        },
        width = 35,
      },
      default_component_configs = {
        indent = { padding = 0 },
        icon = {
          folder_closed = '',
          folder_open = '',
          folder_empty = '',
          folder_empty_open = '',
        },
        git_status = {
          symbols = {
            added = '',
            deleted = '',
            modified = '',
            renamed = '➜',
            untracked = '★',
            ignored = '◌',
            unstaged = '✗',
            staged = '✓',
            conflict = '',
          },
        },
      },
    }
  end,
}
