-- Use my vimrc for most things
vim.cmd("source ~/.vimrc")
-- vim.cmd [[colorscheme unokai]]
-- vim.g.sonokai_style = "andromeda" -- or 'shusia', 'maia', 'espresso', "andromeda
vim.g.sonokai_style = "espresso" -- or 'shusia', 'maia', 'espresso', "andromeda
vim.cmd("colorscheme sonokai")
require("completion")
require("lsp")

--Display errors on stop
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     vim.diagnostic.open_float(nil, { focus = false })
--   end,
-- })

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    -- Check if any floating window is open
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then
        -- A floating window exists (like hover), so don't show diagnostics
        return
      end
    end
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})


--fzf
require('fzf-lua').setup({
  keymap = {
    builtin = {
      ["<C-d>"] = "preview-half-page-down",
      ["<C-u>"] = "preview-half-page-up",
    },
  },
})
vim.keymap.set("n", "<leader>p", require("fzf-lua").files)
vim.keymap.set("n", "<leader>r", require("fzf-lua").live_grep)


