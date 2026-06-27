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
    go = { "goimports", "gofmt" },
    clojure = { "clojure-lsp" },
    edn = { "clojure-lsp" },
    swift = { "swift_format" },
  },

  formatters = {
    swift_format = {
      command = "/Library/Developer/CommandLineTools/usr/bin/swift-format",
    },
  },

  format_on_save = {
    timeout_ms = 2000,
    lsp_fallback = true,
  },
}

return options
