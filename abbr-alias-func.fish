# Abbreviations
abbr --add --global cat bat
abbr --add --global chown sudo chown
abbr --add --global cx chmod +x
abbr --add --global dnf sudo dnf
abbr --add --global gits git status --show-stash --untracked-files=all
abbr --add --global mt multitail
abbr --add --global pip pip3
abbr --add --global psg 'ps -ef | grep -i'
abbr --add --global python python3
abbr --add --global rpm sudo rpm
abbr --add --global setg 'set | grep -i'
abbr --add --global systemctl sudo systemctl
abbr --add --global tigs tig status
abbr --add --global unset set --erase


# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias e=$EDITOR
alias grep='command grep --color=auto'
alias la='/usr/bin/env LC_COLLATE=C /usr/bin/ls --color=auto -lahN'
alias lar='/usr/bin/env LC_COLLATE=C /usr/bin/ls --color=auto -lahNtr'
alias ls='/usr/bin/env LC_COLLATE=C /usr/bin/ls --color=auto -N'


# Functions
function rmv; kioclient5 move $argv 'trash:/'; end
function bcomp; /usr/bin/bcompare $argv &; end
function alias-grep; grep -i $argv $ALIAS_FISH_FILE; end
function alias-edit; $EDITOR $ALIAS_FISH_FILE; source $ALIAS_FISH_FILE; end

