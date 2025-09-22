return {
  'ANGkeith/telescope-terraform-doc.nvim',
  ft = { 'terraform', 'terraform-vars', 'hcl' },
  dependencies = { 'nvim-telescope/telescope.nvim' },
  keys = {
    { '<leader>td', '<cmd>Telescope terraform_doc<cr>', desc = 'Terraform Documentation', ft = { 'terraform', 'terraform-vars', 'hcl' } },
  },
  config = function()
    require('telescope').load_extension('terraform_doc')
  end,
}
