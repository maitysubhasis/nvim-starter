local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    scss = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier", "eslint_d" },
    javascriptreact = { "prettier", "eslint_d" },
    typescript = { "prettier", "eslint_d" },
    typescriptreact = { "prettier", "eslint_d" },
    json = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
