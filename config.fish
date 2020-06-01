# Disable greeting
set fish_greeting

# Environment
set -xg EDITOR vim

# Path
set PATH "$HOME/bin" "$HOME/.local/bin" $PATH

# Abbreviations
abbr --add --global apt sudo aptitude
abbr --add --global chown sudo chown
abbr --add --global cx chmod +x
abbr --add --global fd fdfind
abbr --add --global gits git status
abbr --add --global psg 'ps -ef | grep -i'
abbr --add --global systemctl sudo systemctl
abbr --add --global tigs command tig status
abbr --add --global dpkg sudo dpkg

# Aliases
alias grep='grep --color'
alias ls='env LC_COLLATE=C ls --color=auto -N'
alias la='env LC_COLLATE=C ls --color=auto -lahN'
alias lar='env LC_COLLATE=C ls --color=auto -lahNtr'
alias tig='tig --all'
alias ..='cd ..'
alias ...='cd ../..'

# WSL
if env | grep WSLENV 2>&1 > /dev/null
    source ~/.config/fish/wslenv.fish
end

# Go Home
cd
