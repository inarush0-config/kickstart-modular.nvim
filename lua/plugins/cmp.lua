return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    {
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
    },
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'lukas-reineke/cmp-under-comparator',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    luasnip.config.setup {}
    require('luasnip.loaders.from_vscode').lazy_load()

    local lspkind_comparator = function(conf)
      local lsp_types = require('cmp.types').lsp
      return function(entry1, entry2)
        if entry1.source.name ~= 'nvim_lsp' then
          if entry2.source.name == 'nvim_lsp' then
            return false
          else
            return nil
          end
        end
        local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
        local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
        if kind1 == 'Variable' and entry1:get_completion_item().label:match '%w*=' then
          kind1 = 'Parameter'
        end
        if kind2 == 'Variable' and entry2:get_completion_item().label:match '%w*=' then
          kind2 = 'Parameter'
        end

        local priority1 = conf.kind_priority[kind1] or 0
        local priority2 = conf.kind_priority[kind2] or 0
        if priority1 == priority2 then
          return nil
        end
        return priority2 < priority1
      end
    end

    local label_comparator = function(entry1, entry2)
      return entry1.completion_item.label < entry2.completion_item.label
    end

    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local python_handler = cmp_autopairs.filetypes['python']['('].handler
    cmp_autopairs.filetypes['python']['('].handler = function(char, item, bufnr, rules, commit_character)
      local utils = require 'nvim-autopairs.utils'
      local line = utils.text_get_current_line(bufnr)
      if line:match '^(from.*import.*)$' then
        return
      end
      python_handler(char, item, bufnr, rules, commit_character)
    end

    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,select' },

      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-y>'] = cmp.mapping.confirm { select = true },
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
      },
      sorting = {
        comparators = {
          cmp.config.compare.scope,
          require('cmp-under-comparator').under,
          lspkind_comparator {
            kind_priority = {
              Parameter = 14,
              Method = 13,
              Variable = 12,
              Field = 11,
              Property = 11,
              Constant = 10,
              Enum = 10,
              EnumMember = 10,
              Event = 10,
              Function = 10,
              Operator = 10,
              Reference = 10,
              Struct = 10,
              File = 8,
              Folder = 8,
              Class = 5,
              Color = 5,
              Module = 5,
              Keyword = 2,
              Constructor = 1,
              Interface = 1,
              Snippet = 0,
              Text = 1,
              TypeParameter = 1,
              Unit = 1,
              Value = 1,
            },
          },
          label_comparator,
          cmp.config.compare.score,
        },
      },
    }
  end,
} -- vim: ts=2 sts=2 sw=2 et
