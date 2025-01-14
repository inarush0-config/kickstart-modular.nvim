-- Configuration for mini.nvim modules
return {
  'echasnovski/mini.nvim',
  version = '*', -- Use the latest version
  event = { 'BufReadPost', 'BufNewFile' }, -- Lazy-load modules
  opts = {
    modules = {
      surround = true, -- Enable mini.surround
      pairs = true, -- Enable mini.pairs
      comment = true, -- Enable mini.comment
      ai = true, -- Enable mini.ai
    },
  },
  config = function(_, opts)
    -- Initialize selected modules
    if opts.modules.surround then
      local ok = pcall(require, 'mini.surround')
      if ok then
        require('mini.surround').setup {}
      end
    end
    if opts.modules.pairs then
      local ok = pcall(require, 'mini.pairs')
      if ok then
        require('mini.pairs').setup {}
      end
    end
    if opts.modules.comment then
      local ok = pcall(require, 'mini.comment')
      if ok then
        require('mini.comment').setup {}
      end
    end
    if opts.modules.ai then
      local ok = pcall(require, 'mini.ai')
      if ok then
        require('mini.ai').setup {}
      end
    end
  end,
}
