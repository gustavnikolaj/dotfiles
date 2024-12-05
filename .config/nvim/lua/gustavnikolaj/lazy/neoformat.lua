return {
    "sbdchd/neoformat",
    ft = {"javascript", "lua", "go", "typescript"},
    config = function ()
        vim.g.neoformat_try_node_exe = 1  -- Set Neoformat to try using Node.js executable

        -- Autoformat JavaScript files on save
        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.js",
            callback = function()
                vim.cmd("Neoformat")
            end
        })
    end
}
