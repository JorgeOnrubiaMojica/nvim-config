-- Common
vim.keymap.set("n", "<Tab>", ":bn<cr>", { desc = "Next buffer", silent = true })
vim.keymap.set("n", "<leader>p", ":bp<cr>", { desc = "Previous buffer", silent = true })
vim.keymap.set("n", "<leader>x", ":bd<cr>", { desc = "Close buffer", silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save", silent = true })
vim.keymap.set("n", "<leader>vs", ":vsplit<cr>", { desc = "VSplit", silent = true })
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("i", "jk", "<ESC>", { noremap = true, silent = true })

-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- FzfLua
vim.keymap.set("n", "<leader>?", "<CMD>FzfLua oldfiles<CR>", { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>/", "<CMD>FzfLua lgrep_curbuf<CR>", { desc = "[?] LiveGrep current buffer" })
vim.keymap.set("n", "<leader><space>", "<CMD>FzfLua buffers<CR>", { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>ff", "<CMD>FzfLua git_files<CR>", { desc = "Search [F]iles" })
vim.keymap.set("n", "<leader>fc", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end, { desc = "Search in config directory" })
vim.keymap.set("n", "<leader>fn", function() require("fzf-lua").files({ cwd = '~/Notes' }) end, { desc = "Search in notes directory" })
vim.keymap.set("n", "<leader>sg", "<CMD>FzfLua live_grep<CR>", { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", "<CMD>FzfLua diagnostics_document previewer=false<CR>",
  { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", "<CMD>FzfLua resume<CR>", { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>gs", "<CMD>FzfLua git_status<CR>", { desc = "Git status" })

-- Refactoring
vim.keymap.set({ "n", "x" }, "<leader>ef", function()
  return require("refactoring").refactor("Extract Function")
end, { expr = true })
vim.keymap.set({ "n", "x" }, "<leader>iv", function()
  return require("refactoring").refactor("Extract Variable")
end, { expr = true })

-- LSP
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>am", "<CMD>FzfLua lsp_code_actions previewer=false<CR>", { desc = "Code Actions" })
vim.keymap.set("n", "gd", "<CMD>FzfLua lsp_definitions<CR>", { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gI", "<CMD>FzfLua lsp_implementations<CR>", { desc = "[G]oto [I]mplementation" })
vim.keymap.set("n", "gr", "<CMD>FzfLua lsp_references<CR>", { desc = "[G]oto [r]eferences", silent = true })
vim.keymap.set("n", "<leader>rf", vim.lsp.buf.format, { desc = "Format code" })

-- Reload config
vim.keymap.set("n", "<leader>rcon", function() dofile(vim.fn.stdpath("config") .. "/init.lua") end,
  { desc = "Reload config" })
