vim.lsp.start({
  name = "pyright",
  cmd = { "pyright-langserver", "--stdio" },
})

