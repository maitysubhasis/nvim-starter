-- Strip the per-buffer close button (󰅖) from NvChad's tabufline.
--
-- The icon is hardcoded in nvchad.tabufline.utils.style_buf, which is captured
-- as a local by the modules file, so there is no config flag and no seam to
-- monkey-patch. The tabline expression itself is the one public seam: wrap
-- NvChad's renderer and drop the close button's click region from its output.

local M = {}

-- style_buf emits the per-buffer close button as: %<bufnr>@TbKillBuf@<hl>󰅖<hl>%X
local CLOSE_BTN = "%%%d*@TbKillBuf@.-%%X"

-- The top-right buttons (close-all-buffers + theme toggle) are dropped via the
-- supported `ui.tabufline.modules.btns` override in chadrc, not stripped here.

function M.render()
  local line = require "nvchad.tabufline.modules"()
  return (line:gsub(CLOSE_BTN, ""))
end

function M.setup()
  vim.o.showtabline = 2
  vim.o.tabline = "%!v:lua.require('configs.tabufline').render()"
end

return M
