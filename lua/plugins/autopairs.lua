-- Automatically pairs matching characters (e.g., (), {}, "", '')
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter', -- Load when entering Insert mode for performance
  config = function()
    -- Setup nvim-autopairs with default settings
    require('nvim-autopairs').setup()

    -- Example: Add custom rules (uncomment to enable)
    -- local npairs = require('nvim-autopairs')
    -- local Rule = require('nvim-autopairs.rule')
    -- npairs.add_rules {
    --   Rule('$$', '$$', 'tex') -- Match $$ in LaTeX files
    -- }
  end,
}
