local util = require("colorscheme.util")

local M = {}

M.name = "zathura"

M.path = "zathura"
M.filename = "theme"

M.gen = function(schema)
	local template = util.template(
		[[
set default-fg "${fg}"
set default-bg "${bg}"

set completion-bg "${bg}"
set completion-fg "${fg}"
set completion-highlight-bg "${bg_highlight}"
set completion-highlight-fg "${fg}"
set completion-group-bg "${bg}"
set completion-group-fg "${accent}"

set statusbar-fg "${fg}"
set statusbar-bg "${bg}"

set notification-bg "${bg}"
set notification-fg "${fg}"
set notification-error-bg "${bg}"
set notification-error-fg "${red}"
set notification-warning-bg "${bg}"
set notification-warning-fg "${yellow}"

set inputbar-fg "${fg}"
set inputbar-bg "${bg}"

set recolor-lightcolor "${bg_dark}"
set recolor-darkcolor "${fg}"

set index-fg "${fg}"
set index-bg "${bg_highlight}"
set index-active-fg "${fg}"
set index-active-bg "${bg}"

set render-loading-bg "${bg}"
set render-loading-fg "${fg}"

set highlight-color "${bg_dark}"
set highlight-fg "${fg}"
set highlight-active-color "${accent}"]],
		schema
	)

	return template
end

return M
