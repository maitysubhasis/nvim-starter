require "nvchad.autocmds"

local _nvimtree_width_file = vim.fn.stdpath("data") .. "/sidebar_width"

local function _save_nvimtree_width(width)
  local f = io.open(_nvimtree_width_file, "w")
  if f then f:write(tostring(width)); f:close() end
end

-- Restore saved sidebar width when NvimTree opens
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    local f = io.open(_nvimtree_width_file, "r")
    if f then
      local size = tonumber(f:read("*a"))
      f:close()
      if size then
        vim.schedule(function()
          pcall(require("nvim-tree.api").tree.resize, { absolute = size })
        end)
      end
    end
  end,
})

-- Persist width after any resize (including mouse drag)
vim.api.nvim_create_autocmd("WinResized", {
  callback = function()
    for _, winid in ipairs(vim.v.event.windows or {}) do
      local ok, buf = pcall(vim.api.nvim_win_get_buf, winid)
      if ok and vim.bo[buf].filetype == "NvimTree" then
        _save_nvimtree_width(vim.api.nvim_win_get_width(winid))
        break
      end
    end
  end,
})

-- Remove unused imports on save for JS/TS files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function(args)
    vim.lsp.buf.code_action({
      context = { only = { "source.removeUnusedImports" }, diagnostics = {} },
      apply = true,
      bufnr = args.buf,
    })
  end,
})

-- ESLint fix on save for JS/TS files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
  callback = function()
    vim.cmd("silent! EslintFixAll")
  end,
})