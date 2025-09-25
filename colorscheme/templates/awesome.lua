local util = require("colorscheme.util")

local M = {}

M.name = "awesome"

M.path = "awesome/theme"
M.filename = "palette.lua"

M.gen = function(schema)
	local template = util.template(
		[[
return {
	bg = "${bg}",
	bg_bar = "${bg_bar}",
	bg_dark = "${bg_dark}",
	bg_dark1 = "${bg_dark1}",
	bg_highlight = "${bg_highlight}",
	fg = "${fg}",
	fg_dark = "${fg_dark}",
	dark1 = "${dark1}",
	dark2 = "${dark2}",
	fg_gutter = "${fg_gutter}",
	red = "${red}",
	orange = "${orange}",
	yellow = "${yellow}",
	green = "${green}",
	aqua = "${aqua}",
	blue = "${blue}",
	purple = "${purple}",
	magenta = "${magenta}",
	terminal_black = "${terminal_black}",
	comment = "${comment}",
  accent = "${accent}",
  black = "${black}",
  border = "${border}",
  border_highlight = "${border_highlight}",
  terminal_black_bright = "${terminal_black_bright}",
  terminal_red = "${terminal_red}",
  terminal_red_bright = "${terminal_red_bright}",
  terminal_green = "${terminal_green}",
  terminal_green_bright = "${terminal_green_bright}",
  terminal_yellow = "${terminal_yellow}",
  terminal_yellow_bright = "${terminal_yellow_bright}",
  terminal_blue = "${terminal_blue}",
  terminal_blue_bright = "${terminal_blue_bright}",
  terminal_magenta = "${terminal_magenta}",
  terminal_magenta_bright = "${terminal_magenta_bright}",
  terminal_cyan = "${terminal_cyan}",
  terminal_cyan_bright = "${terminal_cyan_bright}",
  terminal_white = "${terminal_white}",
  terminal_white_bright = "${terminal_white_bright}",
}]],
		schema
	)

	return template
end

return M
