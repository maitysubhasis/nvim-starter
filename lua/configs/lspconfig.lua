-- require("nvchad.configs.lspconfig").defaults()

local servers = { "clangd", "html", "cssls", "gopls", "lua_ls", "ts_ls","pyright", "eslint", "rust_analyzer" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 
