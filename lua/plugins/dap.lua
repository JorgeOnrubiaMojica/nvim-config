return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      { 'rcarriga/nvim-dap-ui',           dependencies = { 'nvim-neotest/nvim-nio' } },
      { 'theHamsta/nvim-dap-virtual-text', opts = {} },
    },
    config = function()
      local dap       = require('dap')
      local dapui     = require('dapui')
      local mason_pkg = vim.fn.stdpath('data') .. '/mason/packages'

      dapui.setup()

      -- Abrir/cerrar la UI automáticamente
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config']     = function() dapui.close() end

      -- ===================== PHP (Xdebug) =====================
      -- Adapter: Felix Becker's vscode-php-debug, instalado por Mason.
      -- Importante: el adapter ESCUCHA en :9003; PHP+Xdebug dentro del
      -- contenedor se conecta hacia él (topología DBGP invertida).
      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { mason_pkg .. '/php-debug-adapter/extension/out/phpDebug.js' },
      }

      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug (Docker)',
          port = 9003,
          -- Mapeo de rutas: [ruta_en_contenedor] = ruta_en_host
          pathMappings = {
            ['/var/www/app'] = vim.fn.getcwd(),
          },
        },
      }

      -- ===================== Keymaps =====================
      local map = function(lhs, rhs, desc)
        vim.keymap.set('n', lhs, rhs, { desc = 'DAP: ' .. desc })
      end

      map('<F5>',  dap.continue,        'Continue')
      map('<F9>',  dap.toggle_breakpoint, 'Toggle breakpoint')
      map('<F10>', dap.step_over,       'Step over')
      map('<F11>', dap.step_into,       'Step into')
      map('<F23>', dap.step_out,        'Step out')       -- Shift+F11
      map('<F17>', dap.close,           'Stop/Close')     -- Shift+F9
      map('<leader>?', dapui.eval,      'Eval under cursor') -- visual mode tb
      vim.keymap.set('v', '<leader>?', function() dapui.eval() end, { desc = 'DAP: Eval selection' })
    end,
  },
}
