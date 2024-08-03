return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('gd', require('telescope.builtin').lsp_definitions, 'Go to definition')
        map('gr', require('telescope.builtin').lsp_references, 'Go to references')
        map('gI', require('telescope.builtin').lsp_implementations, 'Go to implementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type definition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document symbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace symbols')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end

        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = event.buf,
          callback = function()
            vim.lsp.buf.code_action {
              context = { only = { 'source.organizeImports' } },
              apply = true,
            }
            vim.wait(100)
          end,
        })
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    local servers = {
      cypher_ls = {},
      dockerls = {},
      bashls = {},
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      },
      golangci_lint_ls = {
        filetypes = { 'go', 'gomod', 'gotmpl' },
      },
      docker_compose_language_service = {},
      marksman = {},
      phpactor = {},
      pyright = {
        settings = {
          pyright = {
            disableOrganizeImports = true,
            analysis = {
              typeCheckingMode = 'strict',
            },
          },
        },
      },
      ruff = {
        init_options = {
          settings = {
            args = {
              '--select=ALL',
            },
          },
        },
      },
      terraformls = {
        on_attach = function()
          require('treesitter-terraform-doc').setup {}
          vim.keymap.set('n', '<leader>td', ':OpenDoc<CR>', {})
        end,
      },
      yamlls = {
        settings = {
          yaml = {
            format = {
              enable = true,
            },
            hovor = true,
            completion = true,
            schemaStore = {
              enable = false,
              url = '',
            },
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
        },
      },
      lua_ls = {
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
            completion = {
              callSnippet = 'Replace',
            },
            diagnostics = { disable = { 'missing-fields' } },
          },
        },
      },
    }

    require('mason').setup()

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'mdformat',
      'prettier',
      'stylua',
      'taplo',
      'golangci-lint',
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    require('mason-lspconfig').setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}
-- vim: ts=2 sts=2 sw=2 et
