-- start lsp if there is a .git somewhere
vim.lsp.config('*', {
  root_markers = { '.git' },
})

-- Add this once in your config
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    -- F2: rename symbol
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)

    -- F12: go to definition
    vim.keymap.set('n', '<F12>', vim.lsp.buf.definition, opts)

    -- <leader>f: format buffer
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})
