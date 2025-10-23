require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- keymap to jump to definition
map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
-- vim.keymap.set('n', 'gh', vim.lsp.buf.hover, { silent = true })
map("n", "gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "Hover doc" })


-- adds a entry in the 
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { desc = '[F]ind [R]eferences' })

-- Disable Copilot’s default <Tab> mapping
vim.g.copilot_no_tab_map = true

-- Map Ctrl+L to accept Copilot suggestion
vim.keymap.set('i', '<C-l>', 'copilot#Accept("<CR>")', {
  expr = true,
  silent = true,
  replace_keycodes = false,
})