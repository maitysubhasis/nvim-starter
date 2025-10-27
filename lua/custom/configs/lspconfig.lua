-- local on_attach = require("configs.lspconfig").on_attach
-- local capabilities = require("configs.lspconfig").capabilities

local lspconfig = vim.lsp.config  -- ✅ new entry point

local util = require "lspconfig/util"


print(vim.inspect(vim.lsp.get_clients()))
