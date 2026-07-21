return {
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>ef", mode = { "n", "x" } },
      { "<leader>iv", mode = { "n", "x" } },
    },
    config = function()
      require("refactoring").setup()
    end,
  } 
}
