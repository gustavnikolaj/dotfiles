return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		-- Example: Configure Telescope defaults
		require("telescope").setup{
			defaults = {
				-- Your telescope config goes here
			}
		}

		local builtin = require('telescope.builtin')
        --vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>pf', function()
            builtin.find_files({
                hidden = true,
                file_ignore_patterns = { "%.git/" }
            })
        end, {})
		vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
		vim.keymap.set('n', '<C-b>', builtin.buffers, {})
		-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<C-p>', function() builtin.git_files({ show_untracked = true }) end, {})
		vim.keymap.set('n', '<leader>ps', function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end)
	end
}
