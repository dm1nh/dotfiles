# Trop colorscheme for Fish
# ~/.config/fish/conf.d/theme.fish

# --> special
set -l fg d3c6aa
set -l sel 2a3137

# --> palette
set -l red e67e80
set -l green b2c98f
set -l yellow dbbc7f
set -l blue 7ba6d2
set -l magenta d6a0d1
set -l cyan 83c092
set -l black 444a4f

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
    