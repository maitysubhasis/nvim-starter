require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- keymap to jump to definition
map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
-- vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { silent = true })

-- adds a entry in the 
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { desc = '[F]ind [R]eferences' })
