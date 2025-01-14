-- Inline color preview plugin
return {
  'norcalli/nvim-colorizer.lua',
  event = { 'BufReadPost', 'BufNewFile' }, -- Lazy-load on file read or creation
  config = function()
    local ok, colorizer = pcall(require, 'colorizer')
    if not ok then
      vim.notify('Failed to load nvim-colorizer.lua', vim.log.levels.ERROR)
      return
    end

    -- Setup colorizer
    colorizer.setup({
      '*', -- Enable for all file types
    }, {
      mode = 'foreground', -- Highlight mode: "foreground", "background", "virtualtext"
    })

    -- Optionally attach colorizer to the current buffer (uncomment if needed)
    -- vim.cmd [[ColorizerAttachToBuffer]]
  end,
}
