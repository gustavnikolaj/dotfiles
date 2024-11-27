require('gustavnikolaj.lazy_init')
require('gustavnikolaj.remap')
require('gustavnikolaj.set')


--vim.cmd('colorscheme rose-pine')
--vim.cmd('colorscheme grb256')
--vim.cmd('colorscheme nofrils-acme')
--vim.cmd('colorscheme nofrils-sepia')
--vim.cmd('colorscheme nofrils-light')
--vim.cmd('colorscheme nofrils-dark')
--vim.cmd('colorscheme darkness')
--vim.cmd('colorscheme fogbell')
--vim.cmd('colorscheme fogbell_light')
--vim.cmd('colorscheme fogbell_lite')
-- no color collection https://github.com/mcchrish/vim-no-color-collections

-- vim.cmd("colorscheme default")
vim.cmd("colorscheme onenord")

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    command = "setlocal wrap"
})

-- Ignore case in searches
vim.o.ignorecase = true
-- Override 'ignorecase' if the search contains uppercase
vim.o.smartcase = true

