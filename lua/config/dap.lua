local add = require('mini.deps').add

add('mfussenegger/nvim-dap')
add('nvim-neotest/nvim-nio')
add('rcarriga/nvim-dap-ui')
add('theHamsta/nvim-dap-virtual-text')

local php_debug = vim.fn.expand('~/.local/share/nvim/dap/php-debug/out/phpDebug.js')
local dap = require('dap')
dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { php_debug },
}
dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen Xdebug (Docker)',
    port = 9003,
    pathMappings = {
      ['/var/www/api'] = vim.fn.getcwd(),
    },
  },
}

require('dapui').setup()
require('nvim-dap-virtual-text').setup()
dap.listeners.after.event_initialized['dapui_config'] = require('dapui').open
dap.listeners.before.event_terminated['dapui_config'] = require('dapui').close
dap.listeners.before.event_exited['dapui_config'] = require('dapui').close

-- DAP keymaps
vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', function() dap.continue() end, { desc = 'Continue / Start debug' })
vim.keymap.set('n', '<leader>do', function() dap.step_over() end, { desc = 'Step over' })
vim.keymap.set('n', '<leader>di', function() dap.step_into() end, { desc = 'Step into' })
vim.keymap.set('n', '<leader>dO', function() dap.step_out() end, { desc = 'Step out' })
vim.keymap.set('n', '<leader>dt', function() dap.terminate() end, { desc = 'Terminate session' })

-- PHPUnit
vim.api.nvim_create_user_command('PhpUnit', function(ctx)
  local container = vim.g.docker_container
  local config = vim.g.phpunit_config
  local filter = ctx.args ~= '' and ctx.args or vim.fn.expand('<cword>')
  local cmd = 'terminal docker exec -it ' .. container .. ' vendor/bin/phpunit'
    .. (config and ' --config ' .. config or '')
    .. ' --filter=' .. filter
  vim.cmd(cmd)
end, { nargs = '?', complete = 'file' })

vim.keymap.set('n', '<leader>T', '<CMD>PhpUnit<CR>', { desc = 'Run PHPUnit test' })
vim.keymap.set('v', '<leader>T', function()
  vim.cmd('normal! y')
  local filter = vim.fn.getreg('"')
  vim.cmd('PhpUnit ' .. filter)
end, { desc = 'Run PHPUnit on selection' })
