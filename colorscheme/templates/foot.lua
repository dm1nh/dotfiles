local util = require("colorscheme.util")

local M = {}

M.name = "foot"

M.path = "foot"
M.filename = "theme.ini"

M.gen = function(schema)
	local sch = util.remove_hashtag_from_schema(schema)
	local template = util.template(
		[[
# ${theme} colorscheme for foot
[colors]
foreground=${fg}
background=${bg_dark}

cursor=${bg_dark} ${accent}

regular0=${terminal_black}
regular1=${terminal_red}
regular2=${terminal_green}
regular3=${terminal_yellow}
regular4=${terminal_blue}
regular5=${terminal_magenta}
regular6=${terminal_cyan}
regular7=${terminal_white}


bright0=${terminal_black_bright}
bright1=${terminal_red_bright}
bright2=${terminal_green_bright}
bright3=${terminal_yellow_bright}
bright4=${terminal_blue_bright}
bright5=${terminal_magenta_bright}
bright6=${terminal_cyan_bright}
bright7=${terminal_white_bright}

selection-foreground=${bg}
selection-background=${accent}

search-box-no-match=${bg} ${blue}
search-box-match=${bg} ${red}

jump-labels=${bg} ${purple}
urls=${aqua}]],
		sch
	)

	return template
end

return M
