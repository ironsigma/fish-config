# Disable greeting
set fish_greeting

# Load plugins
source /usr/share/autojump/autojump.fish

# Path
set -xg PATH "$PATH:$HOME/.rbenv/bin:$HOME/.local/bin:$HOME/bin"

# Editor
set -xg EDITOR nvim

# Abbreviations
abbr --add --global vim nvim
abbr --add --global code codium
abbr --add --global yarn yarnpkg
abbr --add --global dnf sudo dnf
abbr --add --global psg 'ps -ef | grep -i'

abbr --add --global gits git status
abbr --add --global tigs tig status

