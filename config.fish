# Disable greeting
set fish_greeting


# Global Environment
set -xg GOPATH $HOME/Vendor/go
set -xg EDITOR /usr/bin/vim
set -xg JAVA_HOME /usr/lib64/jvm/java-1.8.0-openjdk-1.8.0
set -xg MAVEN_HOME $HOME/Vendor/maven
set -xg SPARK_HOME $HOME/Vendor/spark
set -xg SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
set -xg ALIAS_FISH_FILE $HOME/.config/fish/abbr-alias-func.fish


# Aliases
source $ALIAS_FISH_FILE


# Binding
bind \er '__fzf_history'
bind \ec '__fzf_cd'
bind \ef '__fzf_find_files'


# Path
for user_path in \
    "$HOME/bin" \
    "$HOME/.local/bin" \
    "$MAVEN_HOME/bin" \
    "$SPARK_HOME/sbin" \
    "$SPARK_HOME/bin" \
    "$GOPATH/bin"

    contains $fish_user_paths $user_path; or set -Ua fish_user_paths $user_path
end


# Autoexec
gpgconf --launch gpg-agent

