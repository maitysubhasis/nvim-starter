return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "quarto" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {
      heading = {
        enabled = true,
        position = "overlay",
        width = "full",
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        enabled = true,
        style = "full",
        border = "thick",
      },
    },
  },

  {
    "arnamak/stay-centered.nvim",
    lazy = false,
    opts = {},
  },

  {
    "isakbm/gitgraph.nvim",
    opts = {},
    keys = {
      {
        "<leader>gl",
        function()
          require("gitgraph").draw({}, { all = true, max_count = 5000 })
        end,
        desc = "GitGraph - Draw",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  -- {
  --   "neovim/nvim-lspconfig",
  --   config = function()
  --     require "configs.lspconfig"
  --     require "custom.configs.lspconfig"
  --   end,
  -- },

  -- Core LSP config (new API)
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      require "configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- Lspsaga UI Enhancements
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },

    config = function()
      require("lspsaga").setup({
        ui = { border = "rounded" },
        code_action = {
          lightbulb = {
            enable = false,
            sign = false,
            virtual_text = false,
          },
        },
      })

      -- Optional: keybinding for hover
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, desc = "Hover doc" })
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
      ensure_installed = {
			"vim", "lua", "vimdoc",
        "markdown", "markdown_inline",
        "html", "css", "typescript",
        "tsx", "javascript",
        "c", "cpp",
        "go", "gomod", "gowork", "gosum",
        "clojure",
        "swift",
  		},
  	},
  },
  {
    "github/copilot.vim",
     -- auto load on startup
    event = "InsertEnter",
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "goimports",
        "gofumpt",
        "typescript-language-server",
        "pyright",
        "zls",
        "clojure-lsp",
      },
    },
  },

  {
    "hedyhli/outline.nvim",
    config = function ()
      require("outline").setup()
    end
  },
  {
    "navarasu/onedark.nvim",
    config = function ()
      require("onedark").setup()
    end
  },
  {
    'esmuellert/nvim-eslint',
    config = function()
      require('nvim-eslint').setup({
        settings = {
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
        },
      })
    end,
  },
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      enable = true,
      max_lines = 4,       -- no limit
      trim_scope = "outer",
      patterns = {
        default = {
          "class",
          "function",
          "method",
          "for",
          "while",
          "if",
          "switch",
          "case",
        },
      },
    },
  },
  -- {
  --   "nvimtools/none-ls.nvim", -- formerly "jose-elias-alvarez/null-ls.nvim"
  --   event = { "BufReadPre", "BufNewFile" },
  --   dependencies = { "nvim-lua/plenary.nvim" },
  --   config = function()
  --     local null_ls = require("null-ls")

  --     null_ls.setup({
  --       sources = {
  --         null_ls.builtins.formatting.eslint_d,
  --         null_ls.builtins.diagnostics.eslint_d,
  --         null_ls.builtins.code_actions.eslint_d,
  --       },
  --       on_attach = function(client, bufnr)
  --         -- Auto-fix + format before save
  --         if client.supports_method("textDocument/formatting") then
  --           vim.api.nvim_clear_autocmds({ buffer = bufnr })
  --           vim.api.nvim_create_autocmd("BufWritePre", {
  --             buffer = bufnr,
  --             callback = function()
  --               vim.lsp.buf.format({ async = false })
  --             end,
  --           })
  --         end
  --       end,
  --     })
  --   end,
  -- },
  {
  'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql', 'redis' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
      'DBUIDelete',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_save_location = '~/.local/share/db_ui'
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dbout",
        callback = function()
          vim.keymap.set('n', '<Leader>S', ':w<CR>', { buffer = true })
        end
      })
    end,
  },
  {
    'stevearc/aerial.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
    event = "LspAttach",
    keys = {
      { "<leader>o", "<cmd>AerialToggle!<CR>", desc = "Toggle outline" },
    },
    config = function()
      require('aerial').setup({
        -- Your config here
      })
    end
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
    }
  },
  {
    "tpope/vim-fugitive"
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      post_restore_cmds = {
        function()
          vim.defer_fn(function()
            vim.cmd("silent! edit")
          end, 50)
        end,
      },
    },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      -- Set fold options
      vim.o.foldcolumn = "1"        -- '0' disables, '1' shows one column
      vim.o.foldlevel = 99          -- Ensure folds are open by default
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      -- Setup UFO
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "lsp", "indent" }
        end,
      })

      -- Keymaps
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with kind" })
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = "Peek fold or show hover" })
    end,
  },
  {
    "MattesGroeger/vim-bookmarks",
    event = "VeryLazy",
    keys = {
      { "mm", "<cmd>BookmarkToggle<CR>", desc = "Toggle bookmark" },
      { "mi", "<cmd>BookmarkAnnotate<CR>", desc = "Add bookmark annotation" },
      { "ma", "<cmd>BookmarkShowAll<CR>", desc = "Show all bookmarks" },
      { "mn", "<cmd>BookmarkNext<CR>", desc = "Next bookmark" },
      { "mp", "<cmd>BookmarkPrev<CR>", desc = "Previous bookmark" },
    },
  },
  {
    "rhysd/clever-f.vim",
    event = "VeryLazy",
    config = function()
      vim.g.clever_f_smart_case = 1
      vim.g.clever_f_fix_key_direction = 1
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "folke/trouble.nvim",
    config = function() require("trouble").setup({}) end,
  },
  -- {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'}

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>DapContinue<CR>", desc = "Continue" },
      { "<leader>di", "<cmd>DapStepInto<CR>", desc = "Step Into" },
      { "<leader>do", "<cmd>DapStepOver<CR>", desc = "Step Over" },
      { "<leader>dO", "<cmd>DapStepOut<CR>", desc = "Step Out" },
      { "<leader>dt", "<cmd>DapTerminate<CR>", desc = "Terminate" },
      { "<leader>dr", "<cmd>DapToggleRepl<CR>", desc = "Toggle REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>dh", function() require("dap.ui.widgets").hover() end, desc = "DAP Hover" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Setup DAP UI
      dapui.setup()

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup({
        enabled = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        commented = false,
        only_first_definition = true,
        all_references = false,
        display_callback = function(variable, _buf, _stackframe, _node)
          return variable.name .. ' = ' .. variable.value
        end,
      })

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Swift DAP config (uses codelldb installed by mason-nvim-dap)
      dap.configurations.swift = {
        {
          name = "Launch Swift",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/.build/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
      }

      -- DAP signs
      vim.fn.sign_define('DapBreakpoint', { text='🔴', texthl='', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointCondition', { text='🟡', texthl='', linehl='', numhl='' })
      vim.fn.sign_define('DapLogPoint', { text='📝', texthl='', linehl='', numhl='' })
      vim.fn.sign_define('DapStopped', { text='▶️', texthl='', linehl='', numhl='' })
      vim.fn.sign_define('DapBreakpointRejected', { text='❌', texthl='', linehl='', numhl='' })
    end,
  },

  -- Mason integration for debug adapters
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = {
        "python",
        "codelldb",
        "node2",
        "delve",
      },
      handlers = {},
    },
  },
  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
    ft = "go",
    config = function()
      require("dap-go").setup()
      vim.keymap.set("n", "<leader>dt", function() require("dap-go").debug_test() end, { desc = "Debug Go test" })
      vim.keymap.set("n", "<leader>dT", function() require("dap-go").debug_last_test() end, { desc = "Debug last Go test" })
    end,
  },
  {
    "cbochs/portal.nvim",
    -- Optional dependencies
    dependencies = {
      "cbochs/grapple.nvim",
      "ThePrimeagen/harpoon"
    },
    lazy = false
  },
  -- {
  --  "folke/snacks.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   ---@type snacks.Config
  --   opts = {
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --     bigfile = { enabled = true },
  --     dashboard = { enabled = true },
  --     explorer = { enabled = true },
  --     indent = { enabled = true },
  --     input = { enabled = true },
  --     picker = { enabled = true },
  --     notifier = { enabled = true },
  --     quickfile = { enabled = true },
  --     scope = { enabled = true },
  --     scroll = { enabled = true },
  --     statuscolumn = { enabled = true },
  --     words = { enabled = true },
  --   },
  -- },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    'saghen/blink.cmp',
    -- optional: provides snippets for the snippet source
    dependencies = { 'rafamadriz/friendly-snippets' },

    -- use a release tag to download pre-built binaries
    version = '1.*',
    -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- If you use nix, you can build from source using latest nightly rust with:
    -- build = 'nix run .#build-plugin',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      keymap = { 
        preset = 'default', 
        ["<C-s>"] = {
          function(cmp)
            -- This function manually triggers the completion menu
            cmp.show()
          end,
          mode = "i", -- Map for insert mode
          desc = "Trigger completion menu",
        } 
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
      },

      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = false } },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  },

  -- Rainbow delimiters (treesitter-based)
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "BufReadPost",
    config = function()
      local rainbow = require("rainbow-delimiters")
      require("rainbow-delimiters.setup").setup({
        strategy = { [""] = rainbow.strategy["global"] },
        query = { [""] = "rainbow-delimiters", clojure = "rainbow-delimiters" },
        highlight = {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        },
      })
    end,
  },

  -- vim-fireplace: Clojure REPL integration (tpope)
  {
    "tpope/vim-fireplace",
    ft = { "clojure", "edn" },
    dependencies = {
      "tpope/vim-dispatch",
      "tpope/vim-salve",
    },
  },
  { "tpope/vim-dispatch", lazy = true },
  { "tpope/vim-salve", ft = { "clojure", "edn" } },

  -- Clojure REPL integration
  {
    "Olical/conjure",
    ft = { "clojure", "edn" },
    init = function()
      vim.g["conjure#mapping#prefix"] = ","
      vim.g["conjure#client#clojure#nrepl#connection#auto_repl#enabled"] = false
    end,
  },
  -- Structural s-expression editing
  {
    "guns/vim-sexp",
    ft = { "clojure", "edn", "fennel", "scheme", "lisp" },
    dependencies = { "tpope/vim-sexp-mappings-for-regular-people" },
  },
  {
    "tpope/vim-sexp-mappings-for-regular-people",
    ft = { "clojure", "edn", "fennel", "scheme", "lisp" },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    ft = { "markdown" },
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  {
    'dmtrKovalenko/fff.nvim',
    build = function()
      -- this will download prebuild binary or try to use existing rustup toolchain to build from source
      -- (if you are using lazy you can use gb for rebuilding a plugin if needed)
      require("fff.download").download_or_build_binary()
    end,
    -- if you are using nixos
    -- build = "nix run .#release",
    opts = { -- (optional)
      debug = {
        enabled = true,     -- we expect your collaboration at least during the beta
        show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
      },
    },
    -- No need to lazy-load with lazy.nvim.
    -- This plugin initializes itself lazily.
    lazy = false,
    keys = {
      {
        "ff", -- try it if you didn't it is a banger keybinding for a picker
        function() require('fff').find_files() end,
        desc = 'FFFind files',
      }
    }
  }, 
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      picker = "telescope",
      enable_builtin = true,
    },
    keys = {
      { "<leader>ghi", "<cmd>Octo issue list<CR>", desc = "List GitHub issues" },
      { "<leader>ghp", "<cmd>Octo pr list<CR>", desc = "List GitHub pull requests" },
      { "<leader>ghn", "<cmd>Octo notification list<CR>", desc = "List GitHub notifications" },
      {
        "<leader>ghs",
        function()
          require("octo.utils").create_base_search_command({ include_current_repo = true })
        end,
        desc = "Search GitHub",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },

}
