-- LSP Configuration and Management
return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'saghen/blink.cmp',
    { 'williamboman/mason.nvim', event = 'VimEnter', config = true },
    { 'williamboman/mason-lspconfig.nvim', config = true },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'j-hui/fidget.nvim', event = 'LspAttach', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
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
      -- pyright = {
      --   filetypes = { 'python' },
      --   settings = {
      --     pyright = {
      --       disableOrganizeImports = true,
      --       analysis = { typeCheckingMode = 'strict' },
      --     },
      --   },
      -- },
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
      lua_ls = {
        filetypes = { 'lua' },
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            completion = { callSnippet = 'Replace' },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    },
  },
  config = function(_, opts)
    local lspconfig = require 'lspconfig'

    -- LSP Keybindings
    local function setup_lsp_keymaps(_, bufnr)
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
      end

      -- Telescope-based LSP functions
      local telescope = require 'telescope.builtin'
      map('gd', telescope.lsp_definitions, 'Go to definition')
      map('gr', telescope.lsp_references, 'Go to references')
      map('gI', telescope.lsp_implementations, 'Go to implementation')
      map('<leader>D', telescope.lsp_type_definitions, 'Type definition')
      map('<leader>ds', telescope.lsp_document_symbols, 'Document symbols')
      map('<leader>ws', telescope.lsp_dynamic_workspace_symbols, 'Workspace symbols')

      -- General LSP functions
      map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
      map('K', vim.lsp.buf.hover, 'Hover Documentation')
      map('gD', vim.lsp.buf.declaration, 'Go to declaration')
    end

    -- Use Mason to install servers and tools
    local ensure_installed = vim.tbl_keys(opts.servers)
    vim.list_extend(ensure_installed, {
      'mdformat',
      'prettier',
      'stylua',
      'taplo',
      'shfmt',
    })

    require('mason-tool-installer').setup {
      ensure_installed = ensure_installed,
    }

    require('mason-lspconfig').setup {
      automatic_installation = true,
      handlers = {
        function(server_name)
          local config = opts.servers[server_name] or {}
          if type(config.settings) == 'function' then
            config.settings = config.settings()
          end
          config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)

          -- Add on_attach to apply keymaps
          config.on_attach = setup_lsp_keymaps

          lspconfig[server_name].setup(config)
        end,
      },
    }
  end,
}
