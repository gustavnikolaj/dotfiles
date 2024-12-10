vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- map ; to :
vim.keymap.set("n", ";", ":")

-- Smart way to move between windows
vim.keymap.set('n', '<C-j>', '<C-W>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-W>k', { silent = true })
vim.keymap.set('n', '<C-h>', '<C-W>h', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-W>l', { silent = true })

-- Remap <leader>gq to gqap
vim.keymap.set('n', '<leader>gq', 'gqap', { silent = true })

-- Move lines around in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Treat long lines as break lines
vim.keymap.set('n', 'j', 'gj', { silent = true })
vim.keymap.set('n', 'k', 'gk', { silent = true })

-- <leader>p in visual mode will paste without putting what you pasted over into
-- your clipboard
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- <leader>y will yank to the system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- shift+j without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- navigate up down (C-u like page up) but keep the cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep the cursor in the middle when you move through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

