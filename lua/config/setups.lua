vim.diagnostic.config({
  virtual_text = {
    severity = vim.diagnostic.severity.WARNING,
  },
  float = {
    border = 'rounded',
    source = 'always',
    focusable = false,
    wrap = true,
  },
})
