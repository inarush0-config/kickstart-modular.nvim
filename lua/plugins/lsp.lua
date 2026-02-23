return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'saghen/blink.cmp',
        { 'mason-org/mason.nvim',          event = 'VimEnter',  config = true },
        { 'mason-org/mason-lspconfig.nvim' },
        { 'j-hui/fidget.nvim',             event = 'LspAttach', opts = {} },
        { 'b0o/schemastore.nvim' },
    },
    config = function()
        -- Keymaps
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

        -- Get capabilities
        local capabilities = require('blink.cmp').get_lsp_capabilities()
        -- Force UTF-8 for all servers
        capabilities.general = capabilities.general or {}
        capabilities.general.positionEncodings = { 'utf-8' }

        -- Define server configurations
        local servers = {
            basedpyright = {
                capabilities = capabilities,
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
                capabilities = capabilities,
                init_options = {
                    settings = { args = { '--select=ALL' } },
                },
            },
            gopls = {
                capabilities = capabilities,
                settings = {
                    gopls = {
                        analyses = { unusedparams = true },
                        staticcheck = true,
                        gofumpt = true,
                    },
                },
            },
            golangci_lint_ls = { capabilities = capabilities },
            terraformls = {
                capabilities = capabilities,
                on_attach = function()
                    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
                        pattern = { '*.tf', '*.tfvars', '*.hcl' },
                        callback = function()
                            vim.lsp.buf.format()
                        end,
                    })
                end,
            },
            ts_ls = { capabilities = capabilities },
            svelte = { capabilities = capabilities },
            lua_ls = { capabilities = capabilities },
            jsonls = {
                capabilities = capabilities,
                settings = {
                    json = {
                        schemas = require('schemastore').json.schemas(),
                        validate = { enable = true },
                    },
                },
            },
            yamlls = {
                capabilities = capabilities,
                settings = {
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
                },
            },
            bashls = { capabilities = capabilities },
            dockerls = { capabilities = capabilities },
            marksman = { capabilities = capabilities },
        }

        -- Configure all servers
        for name, config in pairs(servers) do
            vim.lsp.config(name, config)
        end

        -- Auto-generate ensure_installed from configured servers
        require('mason-lspconfig').setup {
            ensure_installed = vim.tbl_keys(servers),
        }
    end,
}
