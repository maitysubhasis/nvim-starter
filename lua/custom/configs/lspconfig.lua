-- local on_attach = require("configs.lspconfig").on_attach
-- local capabilities = require("configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"

lspconfig.gopls.setup {
  -- on_attach = on_attach,
  -- capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}

lspconfig.ts_ls.setup {
  -- on_attach = on_attach,
  -- capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = util.root_pattern("package.json", "tsconfig.json", ".git"),
  settings = {
    typescript = {
      format = {
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
      },
    },
  },
}
