local util = require("colorscheme.util")

local M = {}

M.name = "hyprland"

M.path = "hypr"
M.filename = "palette.conf"

M.gen = function(schema)
	local sch = util.remove_hashtag_from_schema(schema)
	local template = util.template(
		[[
# ${theme} colorscheme for hyprland.conf
  $accent =           ${accent}
	$bg =               ${bg}
	$bg_bar =           ${bg_bar}
	$bg_dark =          ${bg_dark}
	$bg_dark1 =         ${bg_dark1}
	$bg_highlight =     ${bg_highlight}
	$fg =               ${fg}
	$fg_dark =          ${fg_dark}
	$dark1 =            ${dark1}
	$dark2 =            ${dark2}
	$fg_gutter =        ${fg_gutter}
  $border =           ${border}
  $border_highlight = ${border_highlight}
	$red =              ${red}
	$orange =           ${orange}
	$yellow =           ${yellow}
	$green =            ${green}
	$aqua =             ${aqua}
	$blue =             ${blue}
	$purple =           ${purple}
	$magenta =          ${magenta}
	$terminal_black =   ${terminal_black}
	$comment =          ${comment}
]],
		sch
	)

	return template
end

return M
