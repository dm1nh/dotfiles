local util = require("colorscheme.util")

local M = {}

M.name = "alacritty"

M.path = "alacritty"
M.filename = "theme.toml"

M.gen = function(schema)
	local template = util.template(
		[[
# ${theme} for Alacritty
# ~/.config/alacritty/theme.toml

[colors.cursor]
cursor = "${orange}"
text = "${bg}"

[colors.footer_bar]
background = "${fg}"
foreground = "${bg_dark}"

[colors.hints.end]
background = "${bg_dark1}"
foreground = "${fg}"

[colors.hints.start]
background = "${fg}"
foreground = "${bg_dark1}"

[colors.line_indicator]
background = "None"
foreground = "None"

[colors.bright]
black = "${terminal_black_bright}"
blue = "${terminal_blue_bright}"
cyan = "${terminal_cyan_bright}"
green = "${terminal_green_bright}"
magenta = "${terminal_magenta_bright}"
red = "${terminal_red_bright}"
white = "${terminal_white_bright}"
yellow = "${terminal_yellow_bright}"

[colors.normal]
black = "${terminal_black}"
blue = "${terminal_blue}"
cyan = "${terminal_cyan}"
green = "${terminal_green}"
magenta = "${terminal_magenta}"
red = "${terminal_red}"
white = "${terminal_white}"
yellow = "${terminal_yellow}"

[colors.primary]
background = "${bg}"
bright_foreground = "${fg}"
dim_foreground = "${fg_dark}"
foreground = "${fg}"

[colors.search.focused_match]
background = "${accent}"
foreground = "${bg}"

[colors.search.matches]
background = "${red}"
foreground = "${bg}"

[colors.selection]
background = "${bg_highlight}"
text = "${fg}"

[colors.vi_mode_cursor]
cursor = "${fg}"
text = "${bg}"
    ]],
		schema
	)

	return template
end

return M
