-- require("nvchad.configs.lspconfig").defaults()

-- Configure TypeScript server with inlay hints
vim.lsp.config.ts_ls = {
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        spaceBeforeColon = false
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
        spaceBeforeColon = false
      }
    }
  }
}

-- Configure Rust Analyzer with inlay hints
vim.lsp.config.rust_analyzer = {
  settings = {
    ['rust-analyzer'] = {
      inlayHints = {
        typeHints = {
          enable = true,
          hideNamedConstructor = false,
        },
        parameterHints = {
          enable = true,
        },
        chainingHints = {
          enable = true,
        },
        closureReturnTypeHints = {
          enable = "always",
        },
      }
    }
  }
}

-- Enable inlay hints globally
-- vim.api.nvim_create_autocmd('LspAttach', {
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client and client.server_capabilities.inlayHintProvider then
--       vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
--     end
--   end,
-- })

-- read :h vim.lsp.config for changing options of lsp servers

local servers = { "clangd", "html", "cssls", "gopls", "zls", "lua_ls", "ts_ls", "pyright", "eslint", "rust_analyzer" }
vim.lsp.enable(servers)
