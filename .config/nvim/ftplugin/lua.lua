vim.lsp.start({
    name = "lua_ls",
    cmd = { "lua-language-server" },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})
