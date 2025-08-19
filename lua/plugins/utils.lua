return {
  'jiangmiao/auto-pairs',
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'codedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  'tpope/vim-sleuth',
  { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons', config = function ()
    require("bufferline").setup({})
  end }
}
