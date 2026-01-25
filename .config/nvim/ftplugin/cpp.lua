vim.lsp.start({
  name = 'clangd',
  cmd = {'clangd',
    '--inlay-hints=false',
    '--compile-commands-dir=build',
    '--compile_args_from=filesystem',
    '--all-scopes-completion',
    '--background-index',
    '--clang-tidy',
    '--cross-file-rename',
    '--completion-parse=always',
    '--completion-style=detailed',
    '--function-arg-placeholders',
    '--header-insertion-decorators',
    '--header-insertion=never',
    '--limit-results=0',
    '-j=6',
  },
  root_dir = vim.fs.dirname(vim.fs.find({'Makefile'}, { upward = true })[1]),
})

-- Allow for switching between source and header in cpp files.

local function switch_source_header()
  local params = { uri = vim.uri_from_bufnr(0) }

  vim.lsp.buf_request(0, "textDocument/switchSourceHeader", params, function(err, result)
    if err then
      vim.notify("switchSourceHeader error: " .. err.message, vim.log.levels.ERROR)
      return
    end
    if not result then
      vim.notify("No corresponding source/header found", vim.log.levels.INFO)
      return
    end
    vim.cmd("vsplit " .. vim.uri_to_fname(result))  -- or "edit" if you don't want split
  end)
end

vim.keymap.set("n", "<leader>sh", switch_source_header, { buffer = true })


