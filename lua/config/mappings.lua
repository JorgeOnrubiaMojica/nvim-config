local fzf = require('fzf-lua')
local bufremove = require('mini.bufremove')

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

vim.keymap.set('n', '<leader>w', ':w!<CR>', { desc = 'Save', silent = true })
vim.keymap.set('n', '<Leader>x', bufremove.delete, { desc = 'Delete buffer' })
vim.keymap.set('n', '<Leader>bD', bufremove.wipeout, { desc = 'Wipeout buffer' })
vim.keymap.set('n', '<Tab>', ':bn<cr>', { desc = 'Next buffer', silent = true })
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>?', fzf.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>/', fzf.blines, { desc = 'Live grep current buffer' })
vim.keymap.set('n', '<leader><space>', fzf.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>ff', fzf.git_files, { desc = 'Search [F]iles' })
vim.keymap.set('n', '<leader>fc', function()
  fzf.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Search in config directory' })
vim.keymap.set('n', '<leader>fn', function()
  fzf.files({ cwd = vim.fn.expand('~/Notes') })
end, { desc = 'Search in notes directory' })
vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume' })

vim.keymap.set({ 'n', 'x' }, '<leader>am', vim.lsp.buf.code_action, { desc = 'Code Actions' })

vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gI', fzf.lsp_implementations, { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = '[G]oto [R]eferences' })

vim.keymap.set('n', '<leader>G', '<CMD>Git<CR>', { desc = 'Git' })


vim.keymap.set('n', '<leader>rf', '<CMD>ALEFix<CR>', { desc = 'Format with phpcbf' })
vim.keymap.set('n', '<leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })
vim.keymap.set('n', '<leader>dc', function() require('dap').continue() end, { desc = 'Continue / Start debug' })
vim.keymap.set('n', '<leader>do', function() require('dap').step_over() end, { desc = 'Step over' })
vim.keymap.set('n', '<leader>di', function() require('dap').step_into() end, { desc = 'Step into' })
vim.keymap.set('n', '<leader>dO', function() require('dap').step_out() end, { desc = 'Step out' })
vim.keymap.set('n', '<leader>dt', function() require('dap').terminate() end, { desc = 'Terminate session' })
vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, { desc = 'Rename' })

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
