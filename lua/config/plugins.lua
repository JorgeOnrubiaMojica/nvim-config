local package_root = vim.fn.stdpath('data') .. '/site/pack'
local mini_deps = package_root .. '/deps/opt/mini.nvim'

if not vim.uv.fs_stat(mini_deps) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/echasnovski/mini.nvim',
    mini_deps
  })
end

vim.cmd('packadd mini.nvim')

require('mini.deps').setup({ path = { package_root = package_root } })

local add, later = require('mini.deps').add, require('mini.deps').later

local indentscope = require('mini.indentscope')
indentscope.setup({
  draw = { animation = indentscope.gen_animation.none() },
})


require('mini.ai').setup()
require('mini.bufremove').setup()
require('mini.comment').setup()
require('mini.diff').setup()
require('mini.git').setup()
require('mini.icons').setup()
require('mini.misc').setup()
require('mini.notify').setup()
require('mini.pairs').setup()
require('mini.statusline').setup()
require('mini.surround').setup()
require('mini.tabline').setup()

vim.api.nvim_set_hl(0, 'MiniTablineCurrent', { bg = '#89b4fa', fg = '#1e1e2e', bold = true })
vim.api.nvim_set_hl(0, 'MiniTablineModifiedCurrent', { bg = '#f5c2e7', fg = '#1e1e2e', bold = true })
require('mini.completion').setup()
require('mini.trailspace').setup()
add('folke/which-key.nvim')
require('which-key').setup({})

require('mini.snippets').setup({
  snippets = require('config.snippets'),
})
MiniSnippets.start_lsp_server()
local map = vim.keymap.set
map('i', '<C-j>', function() MiniSnippets.expand() end, { desc = 'Expand snippet' })
map('i', '<C-l>', function() MiniSnippets.jump() end, { desc = 'Jump to next tabstop' })
map('i', '<C-h>', function() MiniSnippets.jump({ backwards = true }) end, { desc = 'Jump to prev tabstop' })
map('i', '<C-x>', function() MiniSnippets.stop() end, { desc = 'Stop snippet session' })

add('stevearc/oil.nvim')
require('oil').setup({ view_options = { show_hidden = true } })

add('nvim-treesitter/nvim-treesitter')
later(function()
  require('nvim-treesitter.configs').setup({
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  })
  require('nvim-treesitter').setup()
end)

add('ibhagwan/fzf-lua')
require('fzf-lua').setup({})

add('tpope/vim-fugitive')

add('MeanderingProgrammer/render-markdown.nvim')
require('render-markdown').setup({})

add('catppuccin/nvim')
require('catppuccin').setup({ flavour = 'mocha' })

add('neovim/nvim-lspconfig')
add('williamboman/mason.nvim')
add('williamboman/mason-lspconfig.nvim')

require('mason').setup()

-- phpantom_lsp: force composer.json as root marker (not .git at monorepo root)
vim.lsp.config.phpantom_lsp = {
  root_markers = { 'composer.json' },
}

require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'sqlls', 'jsonls' },
  automatic_installation = true,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('DisableSemanticTokens', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

add('dense-analysis/ale')
vim.g.ale_linters = {
  php = { 'phpstan' },
}
vim.g.ale_php_phpstan_executable = 'vendor/bin/phpstan'
vim.g.ale_fixers = {
  php = { 'phpcbf' },
}

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


