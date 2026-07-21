return {
  -- Phpactor directo (sin wrapper) - más confiable
  {
    'phpactor/phpactor',
    ft = 'php',
    build = 'composer install --no-dev --optimize-autoloader',
    config = function()
      -- Phpactor se configura automáticamente
      -- Los comandos :Phpactor* estarán disponibles
      
      -- Menú de acciones Phpactor con FzfLua
      local function phpactor_actions_menu()
        local actions = {
          { "Import class", ":PhpactorImportClass" },
          { "Extract method", ":PhpactorExtractMethod" },
          { "Extract constant", ":PhpactorExtractConstant" },
          { "Extract expression", ":PhpactorExtractExpression" },
          { "Generate method", ":PhpactorGenerateMethod" },
          { "Generate accessor (getter/setter)", ":PhpactorGenerateAccessors" },
          { "Implement contracts", ":PhpactorImplementContracts" },
          { "Transform (complete constructor)", ":PhpactorTransform" },
          { "Create new class", ":PhpactorClassNew" },
          { "Copy file", ":PhpactorCopyFile" },
          { "Move file", ":PhpactorMoveFile" },
          { "Expand class", ":PhpactorClassExpand" },
          { "Navigate to", ":PhpactorNavigate" },
          { "Find references", ":PhpactorFindReferences" },
          { "Change visibility", ":PhpactorChangeVisibility" },
          { "Context menu (original)", ":PhpactorContextMenu" },
        }

        local items = {}
        for _, action in ipairs(actions) do
          table.insert(items, action[1])
        end

        require('fzf-lua').fzf_exec(items, {
          prompt = 'Phpactor Actions> ',
          actions = {
            ['default'] = function(selected)
              if not selected or #selected == 0 then return end
              for _, action in ipairs(actions) do
                if action[1] == selected[1] then
                  vim.cmd(action[2])
                  break
                end
              end
            end,
          },
        })
      end

      -- Sobrescribir <leader>am en PHP para usar menú custom con FzfLua
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "php",
        callback = function(args)
          vim.keymap.set('n', '<leader>am', phpactor_actions_menu, 
            { buffer = args.buf, desc = "Phpactor actions (FzfLua)", silent = true })
        end,
      })
    end,
    keys = {
      { '<leader>pm', ':PhpactorContextMenu<CR>', desc = 'Phpactor menu (original)' },
      { '<leader>pn', ':PhpactorClassNew<CR>', desc = 'New class' },
      { '<leader>pe', ':PhpactorExtractMethod<CR>', mode = 'v', desc = 'Extract method' },
      { '<leader>pi', ':PhpactorImportClass<CR>', desc = 'Import class' },
      { '<leader>pg', ':PhpactorGenerateAccessors<CR>', desc = 'Generate getters/setters' },
      { '<leader>pc', ':PhpactorCopyFile<CR>', desc = 'Copy file' },
      { '<leader>pv', ':PhpactorMoveFile<CR>', desc = 'Move file' },
      { '<leader>pt', ':PhpactorTransform<CR>', desc = 'Transform code' },
      -- Buscar implementations de interfaz bajo el cursor (solo PHP)
      -- Sobrescribe el gI de LSP que no funciona en Intelephense
      { 
        'gI', 
        function()
          local word = vim.fn.expand('<cword>')
          vim.cmd('FzfLua grep_project search=implements\\ ' .. word)
        end, 
        desc = 'Find implementations (grep)', 
        ft = 'php' 
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
