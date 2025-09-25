local templates = {
	"ags",
	"alacritty",
	-- "awesome",
	"btop",
	"fish",
	-- "foot",
	"hyprland",
	"imv",
	"rofi",
	"sddm-astronaut-theme",
	"zathura",
}

local modules = {}

for _, t in ipairs(templates) do
	modules[t] = require("colorscheme.templates." .. t)
end

return modules
