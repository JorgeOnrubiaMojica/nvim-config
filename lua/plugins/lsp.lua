return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable({
        'lua_ls',
        'intelephense', -- LSP principal para PHP (mejor performance y completado)
        'tsserver', 
        'marksman',
      })

      -- Configuración específica de Intelephense
      require('lspconfig').intelephense.setup({
        init_options = {
          licenceKey = vim.fn.getenv('INTELEPHENSE_LICENCE_KEY'), -- Lee la licencia de variable de entorno
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
