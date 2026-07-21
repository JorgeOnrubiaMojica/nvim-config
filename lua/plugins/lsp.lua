return {
  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Configurar LSPs con la nueva API de Neovim 0.11+
      vim.lsp.enable({
        'lua_ls',
        'intelephense',  -- Agregado de vuelta
        'ts_ls',
        'marksman',
      })

      -- Configuración específica de Intelephense
      vim.lsp.config.intelephense = {
        cmd = { 'intelephense', '--stdio' },
        filetypes = { 'php' },
        root_markers = { 'composer.json', '.git' },
        init_options = {
          licenceKey = vim.fn.getenv('INTELEPHENSE_LICENCE_KEY'),
        },
        settings = {
          intelephense = {
            files = {
              maxSize = 5000000,
              associations = { '*.php', '*.phtml' },
              exclude = {
                '**/node_modules/**',
                '**/vendor/**/Tests/**',
                '**/vendor/**/tests/**',
              },
            },
            environment = {
              phpVersion = '8.2', -- Ajustá a tu versión de PHP
            },
            diagnostics = {
              enable = true,
            },
            format = {
              enable = false, -- Usá php-cs-fixer o pint para formateo
            },
          },
        },
      }

      -- Keymaps que se setean cuando el LSP se attache
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- Navegación básica (con FzfLua para mejor UX)
          vim.keymap.set('n', 'gd', "<CMD>FzfLua lsp_definitions<CR>", { buffer = bufnr, desc = "Go to definition" })
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
          vim.keymap.set('n', 'gI', "<CMD>FzfLua lsp_implementations<CR>", { buffer = bufnr, desc = "Go to implementation" })
          vim.keymap.set('n', 'gr', "<CMD>FzfLua lsp_references<CR>", { buffer = bufnr, desc = "Find references" })
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = "Hover documentation" })
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = "Signature help" })

          -- Diagnósticos
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Previous diagnostic" })
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, desc = "Next diagnostic" })
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { buffer = bufnr, desc = "Show diagnostic" })

          -- Refactoring básico (vía LSP)
          vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename symbol" })
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code actions" })
          vim.keymap.set('n', '<leader>am', "<CMD>FzfLua lsp_code_actions<CR>", { buffer = bufnr, desc = "Code actions (FzfLua)" })

          -- Formateo (si el LSP lo soporta)
          if client and client.server_capabilities.documentFormattingProvider then
            vim.keymap.set('n', '<leader>f', function()
              vim.lsp.buf.format({ async = true })
            end, { buffer = bufnr, desc = "Format document" })
          end

          -- Workspace
          vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "Add workspace folder" })
          vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "Remove workspace folder" })
          vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, { buffer = bufnr, desc = "List workspace folders" })
        end
      })
    end
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "intelephense",
        "phpstan",
        "php-cs-fixer",
      },
    }
  }
}
