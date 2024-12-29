local util = require("colorscheme.util")

local M = {}

M.name = "rofi"

M.path = "rofi"
M.filename = "theme.rasi"

M.gen = function(schema)
	local template = util.template(
		[[
/* ${theme} colorscheme for Rofi */
/* ~/.config/rofi/theme.rasi */
* {
  none:             #00000000;
  accent:           ${accent};
	bg:               ${bg};
	bgbar:            ${bg_bar};
	bg-dark:          ${bg_dark};
	bg-dark1:         ${bg_dark1};
	bg-highlight:     ${bg_highlight};
	fg:               ${fg};
	fg-dark:          ${fg_dark};
	dark1:            ${dark1};
	dark2:            ${dark2};
	fg-gutter:        ${fg_gutter};
  border:           ${border};
  border-highlight: ${border_highlight};
	red:              ${red};
	orange:           ${orange};
	yellow:           ${yellow};
	green:            ${green};
	aqua:             ${aqua};
	blue:             ${blue};
	purple:           ${purple};
	magenta:          ${magenta};
	terminal-black:   ${terminal_black};
	comment:          ${comment};
}]],
		schema
	)

	return template
end

return M
