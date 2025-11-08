return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
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
    event = { "BufReadPre", "BufNewFile" },
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
        "html", "css", "typescript", 
        "tsx", "javascript",
        "c", "cpp",
  		},
  	},
  },
  -- {
  --   "github/copilot.vim",
  --    -- auto load on startup
  --   event = "InsertEnter",
  -- },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "gopls",
        "typescript-language-server",
        "pyright"
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
      require('nvim-eslint').setup({})
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

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      -- log_level = 'debug',
    },
    ---@type SessionLens
    session_lens = {
      picker = nil, -- "telescope"|"snacks"|"fzf"|"select"|nil Pickers are detected automatically but you can also set one manually. Falls back to vim.ui.select
      load_on_setup = true, -- Only used for telescope, registers the telescope extension at startup so you can use :Telescope session-lens
      picker_opts = nil, -- Table passed to Telescope / Snacks / Fzf-Lua to configure the picker. See below for more information

      ---@type SessionLensMappings
      mappings = {
        -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
        delete_session = { "i", "<C-d>" }, -- mode and key for deleting a session from the picker
        alternate_session = { "i", "<C-s>" }, -- mode and key for swapping to alternate session from the picker
        copy_session = { "i", "<C-y>" }, -- mode and key for copying a session from the picker
      },

      ---@type SessionControl
      session_control = {
        control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
        control_filename = "session_control.json", -- File name of the session control file
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
    config = function()
    end
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
        "codelldb", -- For C/C++/Rust
        "node2",    -- For Node.js/TypeScript
      },
      handlers = {},
    },
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
  -- }
}
