return {
  'Afourcat/treesitter-terraform-doc.nvim',
  branch = 'main',
  ft = { 'terraform', 'terraform-vars', 'hcl' },
  config = function()
    local ok, terraform_doc = pcall(require, 'treesitter-terraform-doc')
    if ok then
      terraform_doc.setup {}

      vim.keymap.set('n', '<leader>td', ':OpenDoc<CR>', {
        desc = 'Open Terraform Documentation',
      })
    else
      vim.notify('treesitter-terraform-doc not found', vim.log.levels.WARN)
    end
  end,
}
