require "nvchad.autocmds"

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