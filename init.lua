vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
  require "floaterminal"
end)

local map = function(type, key, value)
	vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end



-- Show only errors inline (not warnings/info/hints)
vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR }
    },
    signs = false  -- Disable diagnostic signs (including bulb icon)
})

-- Different prefix icons by severity
vim.diagnostic.config({
    virtual_text = {
        prefix = function(diagnostic)
            local icons = {
                [vim.diagnostic.severity.ERROR] = '✘',
                [vim.diagnostic.severity.WARN] = '▲',
                [vim.diagnostic.severity.HINT] = '⚑',
                [vim.diagnostic.severity.INFO] = '»',
            }
            return icons[diagnostic.severity]
        end,
    }
})

-- Custom colors for inline hints
vim.cmd([[
  highlight DiagnosticVirtualTextError guifg=#ff6c6b gui=italic
  highlight DiagnosticVirtualTextWarn guifg=#ECBE7B gui=italic
  highlight DiagnosticVirtualTextInfo guifg=#98be65 gui=italic
  highlight DiagnosticVirtualTextHint guifg=#51afef gui=italic
]])


-- run command on file save
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.go", "*.ts" }, -- Or any other file pattern like "*.py", "main.go"
  callback = function()
    -- vim.cmd("!npx prettier --write %") -- Replace with your desired command
  end,
})




-- show git blame inline text
require('gitsigns').setup({
  current_line_blame = true,  -- Enable blame on current line
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol',  -- 'eol' | 'overlay' | 'right_align'
    delay = 500,  -- Delay in milliseconds before showing blame
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '   <author>, <author_time:%Y-%m-%d> - <summary>',
})


vim.api.nvim_set_hl(0, 'Search', {
  bg = 'LightBlue',
  fg = 'Black'
})

-- Create an autocommand group with the option to clear it first.
-- This prevents the autocommand from being registered multiple times.
vim.api.nvim_create_augroup("FocusLostGroup", { clear = true })
vim.api.nvim_create_augroup("LeaveBufferGroup", { clear = true })

-- Create the autocommand itself.
vim.api.nvim_create_autocmd("FocusLost", {
  group = "FocusLostGroup",
  callback = function()
    -- Use vim.cmd to execute the Vimscript command in Lua.
    -- The silent! and wall commands are executed within this call.
    vim.cmd("silent! wall")
  end,
})

vim.api.nvim_create_autocmd("BufLeave", {
  group = "LeaveBufferGroup",
  pattern = "*",
  callback = function()
    -- This function is executed when you leave a buffer
    vim.cmd("silent! wall")
    -- You can add more Lua code here
  end,
})

vim.cmd [[set title]]
vim.cmd [[set relativenumber]]

require("portal").setup()