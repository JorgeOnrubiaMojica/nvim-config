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

require('config.editor')
require('config.ui')
require('config.lsp')
require('config.dap')
require('config.git')
