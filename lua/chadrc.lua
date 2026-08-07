-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",
	transparency = true,

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }

-- lazyload = false so NvChad sets vim.o.tabline at plugin load, before
-- configs.tabufline overrides it in options.lua
M.ui = {
	tabufline = {
		lazyload = false,
		-- drop the top-right button group: close-all-buffers + theme toggle
		modules = {
			btns = function()
				return ""
			end,
		},
	},
}

--M.plugins = "custom.plugins"

return M
