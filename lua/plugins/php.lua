return {
  -- Phpactor para refactoring avanzado (sin LSP)
  {
    'gbprod/phpactor.nvim',
    build = function()
      require('phpactor.handler.update')()
    end,
    ft = 'php',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig'
    },
    keys = {
      { '<leader>pm', ':PhpactorContextMenu<CR>', desc = 'Phpactor menu' },
      { '<leader>pn', ':PhpactorClassNew<CR>', desc = 'New class' },
      { '<leader>pe', ':PhpactorExtractMethod<CR>', mode = 'v', desc = 'Extract method' },
      { '<leader>pi', ':PhpactorImportClass<CR>', desc = 'Import class' },
      { '<leader>pg', ':PhpactorGenerateAccessors<CR>', desc = 'Generate getters/setters' },
      { '<leader>pc', ':PhpactorCopyFile<CR>', desc = 'Copy file' },
      { '<leader>pv', ':PhpactorMoveFile<CR>', desc = 'Move file' },
    },
    opts = {
      install = {
        bin = vim.fn.stdpath("data") .. "/phpactor/phpactor",
      },
      lspconfig = {
        enabled = false, -- Usamos Intelephense como LSP principal
      },
    },
  },

  -- Neotest para PHPUnit
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-phpunit",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-phpunit")({
            phpunit_cmd = function()
              return "vendor/bin/phpunit" -- Ajustá si usás bin/phpunit en Symfony
            end,
            root_files = { "phpunit.xml", "phpunit.xml.dist" },
          }),
        },
        output = {
          enabled = true,
          open_on_run = "short",
        },
        quickfix = {
          enabled = false,
        },
      })
    end,
    keys = {
      { '<leader>tt', function() require("neotest").run.run() end, desc = "Run nearest test" },
      { '<leader>tf', function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run test file" },
      { '<leader>ts', function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
      { '<leader>to', function() require("neotest").output.open({ enter = true }) end, desc = "Show test output" },
    },
  },
}
