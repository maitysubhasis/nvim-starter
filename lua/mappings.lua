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
vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { desc = '[F]ind [R]eferences' })

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

vim.keymap.set("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format file" })


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


vim.keymap.set("n", "<leader>jb", "<cmd>Portal jumplist backward<cr>")
vim.keymap.set("n", "<leader>jf", "<cmd>Portal jumplist forward<cr>")
vim.keymap.set("n", "<leader>rf", "<cmd>bd|e#<cr>")

map("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Telescope git status" })

-- Sidebar (NvimTree) size presets — persisted across sessions
local _sidebar_size_file = vim.fn.stdpath("data") .. "/sidebar_width"
local _sidebar_sizes = { 25, 35, 45, 60 }

local function _save_sidebar_size(size)
  local f = io.open(_sidebar_size_file, "w")
  if f then f:write(tostring(size)); f:close() end
end

local function _set_sidebar_size(size)
  pcall(require("nvim-tree.api").tree.resize, { absolute = size })
  _save_sidebar_size(size)
end

for i, size in ipairs(_sidebar_sizes) do
  map("n", "<leader>s" .. i, function()
    _set_sidebar_size(size)
  end, { desc = "Sidebar width " .. size })
end

map("n", "<leader>lh", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, {
  desc = "Toggle lsp inlay hint"
})

-- Generate PDF from current file with syntax highlighting
map("n", "<leader>pd", function()
  local current_file = vim.fn.expand("%:p")
  if current_file == "" then
    vim.notify("No file is currently open", vim.log.levels.ERROR)
    return
  end

  local html_file = current_file .. ".highlighted.html"
  local pdf_file = current_file .. ".pdf"

  vim.notify("Generating PDF from " .. vim.fn.expand("%:t") .. "...", vim.log.levels.INFO)

  -- Generate HTML with pygmentize, then inject larger font size CSS
  local cmd = string.format(
    "pygmentize -f html -O full,style=colorful,linenos=table -o %s %s && " ..
    "sed -i 's/<\\/style>/ body { font-size: 20pt; } pre { font-size: 18pt; }<\\/style>/' %s && " ..
    "wkhtmltopdf --page-size A4 --margin-top 10mm --margin-bottom 10mm --margin-left 20mm --margin-right 10mm %s %s",
    vim.fn.shellescape(html_file),
    vim.fn.shellescape(current_file),
    vim.fn.shellescape(html_file),
    vim.fn.shellescape(html_file),
    vim.fn.shellescape(pdf_file)
  )

  vim.fn.jobstart(cmd, {
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.notify("PDF generated: " .. vim.fn.fnamemodify(pdf_file, ":t"), vim.log.levels.INFO)
        -- Optionally remove the intermediate HTML file
        vim.fn.delete(html_file)
      else
        vim.notify("Failed to generate PDF", vim.log.levels.ERROR)
      end
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end, { desc = "Generate PDF from current file" })