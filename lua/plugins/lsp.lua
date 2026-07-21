return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- Usar la nueva API de Neovim 0.11+
      vim.lsp.enable({
        'lua_ls',
        'intelephense',
        'ts_ls', -- tsserver está deprecated, se renombró a ts_ls
        'marksman',
      })

      -- Configuración específica de Intelephense con nueva API
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
