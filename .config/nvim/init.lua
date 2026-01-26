-- Use my vimrc for most things
vim.cmd("source ~/.vimrc")
-- vim.cmd [[colorscheme unokai]]
-- vim.g.sonokai_style = "andromeda" -- or 'shusia', 'maia', 'espresso', "andromeda
vim.g.sonokai_style = "espresso" -- or 'shusia', 'maia', 'espresso', "andromeda
-- vim.g.sonokai_style = "espresso" -- or 'shusia', 'maia', 'espresso', "andromeda
-- vim.cmd("colorscheme sonokai")
vim.cmd("colorscheme dayfox")
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

-- local function update_colorscheme()
--   local hour = tonumber(os.date("%H"))
--   if hour >= 19 or hour < 7 then
--     -- Night time: use dark colorscheme
--     vim.cmd("colorscheme gruvbox")  -- replace with your preferred dark scheme
--   else
--     -- Day time: use light colorscheme
--     vim.cmd("colorscheme papercolor")  -- replace with your preferred light scheme
--   end
-- end

-- -- Run once on startup
-- update_colorscheme()

-- -- Set up a timer to check every 10 minutes
-- local timer = vim.loop.new_timer()
-- timer:start(0, 10 * 60 * 1000, vim.schedule_wrap(function()
--   update_colorscheme()
-- end))


