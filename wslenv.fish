# Environment
set -xg GPG_TTY (tty)

# Path
for path in "/mnt/c/util"
    if not contains $path $PATH; and not contains $path $fish_user_paths
        set -Ua fish_user_paths $path
    end
end
