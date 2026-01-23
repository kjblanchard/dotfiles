-- Use my vimrc for most things
vim.cmd("source ~/.vimrc")
-- vim.cmd [[colorscheme unokai]]
-- vim.g.sonokai_style = "andromeda" -- or 'shusia', 'maia', 'espresso', etc.
vim.cmd("colorscheme sonokai")
require("completion")
require("lsp")

--Display errors on stop
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

--fzf
vim.keymap.set("n", "<leader>p", require("fzf-lua").files)
vim.keymap.set("n", "<leader>r", require("fzf-lua").live_grep)

