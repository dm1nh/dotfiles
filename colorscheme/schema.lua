local util = require("colorscheme.util")

local palette = {
	bg = "#23292e",
	bg_bar = "#171b1f",
	bg_dark = "#1e2428",
	bg_dark1 = "#1a1f22",
	bg_highlight = "#2a3137",
	fg = "#d3c6aa",
	fg_dark = "#a99e88",
	dark1 = "#7a8478",
	dark2 = "#555c54",
	fg_gutter = "#494f48",
	red = "#e67e80",
	orange = "#e69875",
	yellow = "#dbbc7f",
	green = "#b2c98f",
	aqua = "#83c092",
	blue = "#7ba6d2",
	purple = "#ad85d7",
	magenta = "#d6a0d1",
	terminal_black = "#444a4f",
	comment = "#585f56",
}

util.bg = palette.bg
util.fg = palette.fg

palette.accent = palette.green
palette.black = palette.terminal_black
palette.border = palette.dark2
palette.border_highlight = palette.accent

palette.terminal_black_bright = palette.terminal_black
palette.terminal_red = palette.red
palette.terminal_red_bright = util.brighten(palette.red)
palette.terminal_green = palette.green
palette.terminal_green_bright = util.brighten(palette.green)
palette.terminal_yellow = palette.yellow
palette.terminal_yellow_bright = util.brighten(palette.yellow)
palette.terminal_blue = palette.blue
palette.terminal_blue_bright = util.brighten(palette.blue)
palette.terminal_magenta = palette.magenta
palette.terminal_magenta_bright = util.brighten(palette.magenta)
palette.terminal_cyan = palette.aqua
palette.terminal_cyan_bright = util.brighten(palette.aqua)
palette.terminal_white = palette.fg_dark
palette.terminal_white_bright = palette.fg

return {
	theme = "Trop",
	palette = palette,
}
