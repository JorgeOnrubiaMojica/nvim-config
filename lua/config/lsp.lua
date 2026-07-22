local add, later = require('mini.deps').add, require('mini.deps').later

add('neovim/nvim-lspconfig')
add('williamboman/mason.nvim')
add('williamboman/mason-lspconfig.nvim')

require('mason').setup()

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

-- ALE (linting + fixing)
add('dense-analysis/ale')
vim.g.ale_linters = {
  php = { 'phpstan' },
}
vim.g.ale_php_phpstan_executable = 'vendor/bin/phpstan'
vim.g.ale_fixers = {
  php = { 'phpcbf' },
}

-- LSP keymaps
local fzf = require('fzf-lua')
vim.keymap.set('n', 'gd', fzf.lsp_definitions, { desc = '[G]oto [D]efinition' })
vim.keymap.set('n', 'gI', fzf.lsp_implementations, { desc = '[G]oto [I]mplementation' })
vim.keymap.set('n', 'gr', fzf.lsp_references, { desc = '[G]oto [R]eferences' })
vim.keymap.set({ 'n', 'x' }, '<leader>am', vim.lsp.buf.code_action, { desc = 'Code Actions' })
vim.keymap.set('n', '<leader>rr', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<leader>rf', '<CMD>ALEFix<CR>', { desc = 'Format with phpcbf' })
