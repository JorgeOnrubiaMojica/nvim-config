return {
  {
    "stevearc/aerial.nvim",
    opts = {},
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      {
        "<leader>l",
        "<cmd>AerialToggle<cr>",
        desc = "Symbol outline",
      },
    },
  },
}
