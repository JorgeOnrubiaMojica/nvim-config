return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.enable({
        'lua_ls',
        'phpactor',
        'tsserver', 
        'marksman',
      })
    end
  },
  {
    "mason-org/mason.nvim",
    opts = {}
  }
}
