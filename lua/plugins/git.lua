return {
  'lewis6991/gitsigns.nvim',
  'tpope/vim-fugitive',
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    },
    -- runs BEFORE the plugin loads so EDITOR=nvr is set when lazygit spawns.
    -- requires `brew install neovim-remote` (nvr) to be on $PATH.
    init = function()
      vim.g.lazygit_use_neovim_remote = 1
    end,
  }
}
