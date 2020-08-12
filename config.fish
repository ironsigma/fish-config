# Disable greeting
set fish_greeting

# Global Environment
set -xg GOPATH $HOME/Vendor/go
set -xg EDITOR /usr/bin/vim
set -xg JAVA_HOME /usr/lib64/jvm/java-1.8.0-openjdk-1.8.0
set -xg MAVEN_HOME $HOME/Vendor/maven
set -xg SPARK_HOME $HOME/Vendor/spark
set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -xg FLATPAK_USER_DIR /flatpak


# WSL
if env | command grep WSLENV 2>&1 > /dev/null
    source ~/.config/fish/wslenv.fish
end


# Abbreviations
abbr --add --global chown sudo chown
abbr --add --global cx chmod +x
abbr --add --global gits git status --show-stash --untracked-files=all
abbr --add --global manx man -Hopera
abbr --add --global pip pip3
abbr --add --global psg 'ps -ef | grep -i'
abbr --add --global python python3
abbr --add --global rpm sudo rpm
abbr --add --global setg 'set | grep -i'
abbr --add --global systemctl sudo systemctl
abbr --add --global tigs tig status
abbr --add --global zearch sudo zypper --no-refresh search
abbr --add --global zinstall sudo zypper install -y
abbr --add --global zypper sudo zypper

# Binding
bind \er '__fzf_history'
bind \ec '__fzf_cd'
bind \ef '__fzf_find_files'


# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias e=$EDITOR
alias grep='command grep --color=auto'
alias la='env LC_COLLATE=C /usr/bin/ls --color=auto -lahN'
alias lar='env LC_COLLATE=C /usr/bin/ls --color=auto -lahNtr'


# Path
for path in "$MAVEN_HOME/bin" \
            "$SPARK_HOME/sbin" \
            "$SPARK_HOME/bin" \
            "$GOPATH/bin" \
            "$HOME/bin" \
            "$HOME/.local/bin"
    if not contains $path $PATH; and not contains $path $fish_user_paths
        set -Ua fish_user_paths $path
    end
end


# Autoexec
gpgconf --launch gpg-agent
