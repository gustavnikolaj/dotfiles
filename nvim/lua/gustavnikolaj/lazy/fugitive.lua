return {
  "tpope/vim-fugitive",
  config = function()
    -- vim.keymap.set("n", "<leader>gs", vim.cmd.Git) -- Git status

    vim.keymap.set('n', '<leader>gs', function()
      local windows = vim.api.nvim_list_wins()
      for _, v in pairs(windows) do
        local status, _ = pcall(vim.api.nvim_win_get_var, v, 'fugitive_status')
        if status then
          vim.api.nvim_win_close(v, false)
          return
        end
      end
      vim.cmd("Git")
    end, { desc = '[G]it to[G]gle' })
  end
}

