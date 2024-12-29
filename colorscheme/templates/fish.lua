local util = require("colorscheme.util")

local M = {}

M.name = "fish"

M.path = "fish/conf.d"
M.filename = "theme.fish"

M.gen = function(schema)
	local sch = util.remove_hashtag_from_schema(schema)
	local template = util.template(
		[[
# ${theme} colorscheme for Fish
# ~/.config/fish/conf.d/theme.fish

# --> special
set -l fg ${fg}
set -l sel ${bg_highlight}

# --> palette
set -l red ${terminal_red}
set -l green ${terminal_green}
set -l yellow ${terminal_yellow}
set -l blue ${terminal_blue}
set -l magenta ${terminal_magenta}
set -l cyan ${terminal_cyan}
set -l black ${terminal_black}

# Syntax Highlighting
set -g fish_color_normal $fg
set -g fish_color_command $green
set -g fish_color_param $fg
set -g fish_color_keyword $red
set -g fish_color_quote $green
set -g fish_color_redirection $magenta
set -g fish_color_end $yellow
set -g fish_color_error $red
set -g fish_color_gray $black
set -g fish_color_selection --background=$sel
set -g fish_color_search_match --background=$sel
set -g fish_color_operator $blue
set -g fish_color_escape $red
set -g fish_color_autosuggestion $black
set -g fish_color_cancel $red

# Prompt
set -g fish_color_cwd $yellow
set -g fish_color_user $cyan
set -g fish_color_host $blue

# Completion Pager
set -g fish_pager_color_progress $black
set -g fish_pager_color_prefix $magenta
set -g fish_pager_color_completion $fg
set -g fish_pager_color_description $black
    ]],
		sch
	)

	return template
end

return M
