local gears = require("gears")
local gfs = gears.filesystem
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path .. "default/theme.lua")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")
local icons = require("theme.icons")
local palette = require("theme.palette")

-- fonts
theme.font_sans = "JetBrainsMonoNL Nerd Font"
theme.font = theme.font_sans .. " Regular 12"
theme.font_icon = "Material Symbols Rounded"
theme.font_icon_default = theme.font_icon .. " 15"

-- colors
theme.transparent = "#00000000"
theme = gears.table.crush(theme, palette)

-- black
theme.color0 = theme.terminal_black
theme.color8 = theme.terminal_black_bright
-- red
theme.color1 = theme.terminal_red
theme.color9 = theme.terminal_red_bright
-- green
theme.color2 = theme.terminal_green
theme.color10 = theme.terminal_green_bright
-- yellow
theme.color3 = theme.terminal_yellow
theme.color11 = theme.terminal_yellow_bright
-- blue
theme.color4 = theme.terminal_blue
theme.color12 = theme.terminal_blue_bright
-- magenta
theme.color5 = theme.terminal_magenta
theme.color13 = theme.terminal_magenta_bright
-- cyan
theme.color6 = theme.terminal_cyan
theme.color14 = theme.terminal_cyan_bright
-- white
theme.color7 = theme.terminal_white
theme.color15 = theme.terminal_white_bright

-- layout icons
theme.layout_tile = icons.layouts.tile
theme.layout_dwindle = icons.layouts.dwindle
theme.layout_floating = icons.layouts.floating
theme.layout_max = icons.layouts.max

theme.master_width_factor = 0.561
theme.master_count = 1
theme.column_count = 1

-- wibar
theme.wibar_height = dpi(28)

-- gaps
theme.useless_gap = 2

--- systray
theme.systray_icon_size = dpi(16)
theme.systray_icon_spacing = dpi(12)
theme.bg_systray = theme.dark

-- Tooltips
theme.tooltip_bg = theme.bg_dark1
theme.tooltip_fg = theme.fg
theme.tooltip_shape = helpers.ui.rrect(dpi(2))
theme.tooltip_gaps = dpi(4)
theme.tooltip_opacity = 0.8

-- Borders
theme.border_width = 2
theme.border_radius = 8
theme.border_color_floating_active = theme.accent
theme.border_color_floating_normal = theme.border
theme.border_color_urgent = theme.red
theme.border_color_active = theme.accent
theme.border_color_normal = theme.border

-- Opacity, enabled if xcompmgr is installed
-- theme.opacity_normal = 0.8
-- theme.opacity_active = 1.0

-- Notifications
theme.notification_spacing = dpi(4)
theme.notification_bg = theme.bg_dark
theme.notification_border_width = 0
theme.notification_border_color = theme.transparent

-- Tasklist
theme.tasklist_plain_task_name = true
theme.tasklist_fg_normal = theme.fg
theme.tasklist_bg_normal = theme.bg_dark1
theme.tasklist_fg_focus = theme.accent
theme.tasklist_bg_focus = theme.bg_highlight
theme.tasklist_fg_urgent = theme.fg
theme.tasklist_bg_urgent = theme.red
theme.tasklist_fg_minimize = theme.bg_dark1
theme.tasklist_bg_minimize = theme.blue
theme.tasklist_shape = helpers.ui.rrect(dpi(2))

-- Swallowing
theme.dont_swallow_classname_list = {
  "firefox",
  "firefox-developer-edition",
  "chromium",
  "gimp",
  "Google-chrome",
}

return theme
