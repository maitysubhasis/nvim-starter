require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorline = true -- Enable cursorline highlighting
o.cursorlineopt = 'both' -- Highlight both line number and line background

-- Enable treesitter-based folding
-- o.foldmethod = 'expr'
-- o.foldexpr = 'nvim_treesitter#foldexpr()'
o.foldenable = false  -- Don't fold by default when opening files
o.foldlevel = 99      -- High value = most folds open by default
