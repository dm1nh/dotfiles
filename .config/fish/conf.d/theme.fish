# tokyonight colorscheme for Fish
# ~/.config/fish/conf.d/theme.fish

# --> special
set -l fg c8d3f5
set -l sel 2f334d

# --> palette
set -l red ff757f
set -l green c3e88d
set -l yellow ffc777
set -l blue 82aaff
set -l magenta c099ff
set -l cyan 86e1fc
set -l black 444a73

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
    