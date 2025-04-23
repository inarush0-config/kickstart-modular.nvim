vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = { '*.tfvars' },
  callback = function()
    vim.bo.filetype = 'terraform-vars'
  end,
})
