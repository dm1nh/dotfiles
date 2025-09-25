local util = require("colorscheme.util")

local M = {}

M.name = "ags"

M.path = "ags/styles"
M.filename = "colors.scss"

M.gen = function(schema)
	local template = util.template(
		[[
/* ${theme} colorscheme for AGS */
/* ~/.config/ags/styles/colors.scss */
$accent:           ${accent};
$bg:               ${bg};
$bg-bar:           ${bg_bar};
$bg-dark:          ${bg_dark};
$bg-dark1:         ${bg_dark1};
$bg-highlight:     ${bg_highlight};
$fg:               ${fg};
$fg-dark:          ${fg_dark};
$dark1:            ${dark1};
$dark2:            ${dark2};
$fg-gutter:        ${fg_gutter};
$border:           ${border};
$border-highlight: ${border_highlight};
$red:              ${red};
$orange:           ${orange};
$yellow:           ${yellow};
$green:            ${green};
$aqua:             ${aqua};
$blue:             ${blue};
$purple:           ${purple};
$magenta:          ${magenta};
$black:            ${black};
$terminal-black:   ${terminal_black};
$comment:          ${comment};
]],
		schema
	)

	return template
end

return M
