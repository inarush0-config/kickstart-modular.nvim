-- Plugin for toggling comments
return {
  'numToStr/Comment.nvim',
  event = { 'BufReadPost', 'BufNewFile' }, -- Lazy-load on file read or creation

  config = function()
    require('Comment').setup {
      mappings = {
        basic = true, -- Enable `gc` and `gb` mappings
        extra = false, -- Disable `gco`, `gcO`, and `gcA`
        extended = false, -- Disable `g>`, `g<` for indentation-based comments
      },
    }
  end,
}
