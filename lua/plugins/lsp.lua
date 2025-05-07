return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'saghen/blink.cmp',
    { 'mason-org/mason.nvim', event = 'VimEnter', config = true },
    { 'mason-org/mason-lspconfig.nvim', config = true },
    { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {} },
    { 'b0o/schemastore.nvim' },
  },
  opts = {
    servers = {
      cypher_ls = { filetypes = { 'cypher' } },
      dockerls = { filetypes = { 'dockerfile' } },
      bashls = { filetypes = { 'sh', 'bash' } },
      jsonls = {
        filetypes = { 'json', 'jsonc' },
        settings = function()
          local ok, schemastore = pcall(require, 'schemastore')
          return {
            json = {
              schemas = ok and schemastore.json.schemas() or {},
              validate = { enable = true },
            },
          }
        end,
      },
      gopls = {
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
            gofumpt = true,
          },
        },
      },
      golangci_lint_ls = { filetypes = { 'go', 'gomod', 'gotmpl' } },
      templ = { filetypes = { 'templ' } },
      docker_compose_language_service = {},
      marksman = { filetypes = { 'markdown', 'markdown.mdx' } },
      phpactor = { filetypes = { 'php' } },
      basedpyright = {
        filetypes = { 'python' },
        settings = {
          basedpyright = {
            disableOrganizeImports = true,
            analysis = {
              diagnosticMode = 'workspace',
            },
          },
        },
      },
      ruff = {
        filetypes = { 'python' },
        init_options = {
          settings = { args = { '--select=ALL' } },
        },
      },
      terraformls = {
        filetypes = { 'terraform', 'terraform-vars', 'hcl' },
        on_attach = function()
          vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
            pattern = { '*.tf', '*.tfvars', '*.hcl' },
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end,
      },
      ts_ls = {},
      yamlls = {
        filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.cloudformation' },
        capabilities = {
          workspace = {
            didChangeConfiguration = { dynamicRegistration = true },
          },
        },
        settings = function()
          return {
            yaml = {
              format = { enable = true },
              hover = true,
              completion = true,
              validate = true,
              schemaStore = { enable = false },
              schemas = require('schemastore').yaml.schemas(),
              customTags = {
                '!fn',
                '!And',
                '!If',
                '!Not',
                '!Equals',
                '!Or',
                '!FindInMap sequence',
                '!Base64',
                '!Cidr',
                '!Ref',
                '!Ref Scalar',
                '!Sub',
                '!GetAtt',
                '!GetAZs',
                '!ImportValue',
                '!Select',
                '!Split',
                '!Join sequence',
              },
            },
          }
        end,
      },
      lua_ls = {},
    },
  },
  config = function(_, opts)
    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = 'LSP: ' .. desc })
    end

    local telescope = require 'telescope.builtin'
    map('gd', telescope.lsp_definitions, 'Go to definition')
    map('gr', telescope.lsp_references, 'Go to references')
    map('gI', telescope.lsp_implementations, 'Go to implementation')
    map('<leader>D', telescope.lsp_type_definitions, 'Type definition')
    map('<leader>ds', telescope.lsp_document_symbols, 'Document symbols')
    map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, 'Workspace symbols')

    map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
    map('K', vim.lsp.buf.hover, 'Hover Documentation')
    map('gD', vim.lsp.buf.declaration, 'Go to declaration')

    local ensure_installed = vim.tbl_keys(opts.servers)

    require('mason-lspconfig').setup {
      ensure_installed = ensure_installed,
      automatic_enable = true,
    }
  end,
}
