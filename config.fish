# Disable greeting
set fish_greeting


# Environment
set -xg EDITOR vim
set -xg JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
set -xg MAVEN_HOME $HOME/Vendor/maven
set -xg SPARK_HOME $HOME/Vendor/spark


# WSL
if env | grep WSLENV 2>&1 > /dev/null
    source ~/.config/fish/wslenv.fish
end


# Abbreviations
abbr --add --global apt sudo aptitude
abbr --add --global chown sudo chown
abbr --add --global cx chmod +x
abbr --add --global fd fdfind
abbr --add --global gits git status --show-stash --untracked-files=all
abbr --add --global psg 'ps -ef | grep -i'
abbr --add --global systemctl sudo systemctl
abbr --add --global tigs command tig status
abbr --add --global dpkg sudo dpkg


# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias e=$EDITOR
alias grep='grep --color'
alias la='env LC_COLLATE=C ls --color=auto -lahN'
alias lar='env LC_COLLATE=C ls --color=auto -lahNtr'
alias ls='env LC_COLLATE=C ls --color=auto -N'
alias tig='tig --all'


# Path
for path in "$MAVEN_HOME/bin" \
            "$SPARK_HOME/sbin" \
            "$SPARK_HOME/bin" \
            "$HOME/bin" \
            "$HOME/.local/bin"
    if not contains $path $PATH; and not contains $path $fish_user_paths
        set -Ua fish_user_paths $path
    end
end


# Go Home
cd
