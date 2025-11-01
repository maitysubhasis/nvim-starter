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


vim.keymap.set('n', '<leader>dbc', function()
  local dbui = vim.b.dbui_db_key_name
  
  if not dbui then
    vim.notify("No active DBUI connection found", vim.log.levels.ERROR)
    return
  end

   -- Remove _files suffix if present
  local connection_name = dbui:gsub("_file$", "")
  
  local query_name = vim.fn.input('Query name: ')
  if query_name == '' then
    return
  end
  
  local connection_dir = vim.fn.expand(vim.g.db_ui_save_location) .. '/' .. connection_name
  
  vim.notify(connection_dir)
  -- Create directory if it doesn't exist
  vim.fn.system('mkdir -p ' .. vim.fn.shellescape(connection_dir))

  
  local save_path = connection_dir .. '/' .. query_name
  vim.cmd('write ' .. save_path)
  vim.notify('Saved: ' .. query_name, vim.log.levels.INFO)

  -- - Refresh DBUI - try one of these:
  vim.schedule(function()
    if vim.fn.exists(':DBUIFindBuffer') == 2 then
      vim.cmd('DBUIFindBuffer')
    end
    -- Force a redraw
    pcall(function()
      require('dbui').refresh()
    end)
  end)

end, { desc = 'DBUI Save Query' })

vim.keymap.set('n', '<leader>dbu', function() 
  vim.cmd('DBUIToggle')
end)

vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, {desc = "LSP Rename"})


-- vim.keymap.set("n", "g;", ";", { noremap = true })
-- vim.keymap.set("n", "g,", ",", { noremap = true })

vim.keymap.set("n", "gD", function()
  vim.cmd("split")
  vim.lsp.buf.definition()
end, { silent = true, desc = "Go to definition (split window)" })

vim.keymap.set("n", "gV", function()
  vim.cmd("vsplit")
  vim.lsp.buf.definition()
end, { silent = true, desc = "Go to definition (vertical split)" })


vim.keymap.set("n", "gt", function()
  vim.cmd("tab split")
  vim.lsp.buf.definition()
end, { silent = true, desc = "Go to definition (new tab)" })
