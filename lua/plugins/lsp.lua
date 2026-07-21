return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- blink.cmp capabilities must be set before servers start
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

      vim.lsp.config['*'] = {
        capabilities = capabilities,
      }

      vim.lsp.enable({
        'lua_ls',
        'phpactor',
        'marksman',
        'sqlls',
        'biome',
        'vtsls',
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          if client.supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf })
              end,
            })
          end

          local map = function(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = args.buf, desc = desc })
          end

          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
        end,
      })
    end,
  },
  {
    'mason-org/mason.nvim',
    opts = {},
  },
}
