local util = require("colorscheme.util")

local M = {}

M.name = "ags"

M.path = "ags/styles"
M.filename = "_palette.scss"

M.gen = function(schema)
	local template = util.template(
		[[
/* ${theme} colorscheme for eww */
/* ~/.config/ags/styles/_palette.scss */
  $accent:           ${accent};
	$bg:               ${bg};
	$bg_bar:           ${bg_bar};
	$bg_dark:          ${bg_dark};
	$bg_dark1:         ${bg_dark1};
	$bg_highlight:     ${bg_highlight};
	$fg:               ${fg};
	$fg_dark:          ${fg_dark};
	$dark1:            ${dark1};
	$dark2:            ${dark2};
	$fg_gutter:        ${fg_gutter};
  $border:           ${border};
  $border_highlight: ${border_highlight};
	$red:              ${red};
	$orange:           ${orange};
	$yellow:           ${yellow};
	$green:            ${green};
	$aqua:             ${aqua};
	$blue:             ${blue};
	$purple:           ${purple};
	$magenta:          ${magenta};
  $black:            ${black};
	$terminal_black:   ${terminal_black};
	$comment:          ${comment};
]],
		schema
	)

	return template
end

return M
