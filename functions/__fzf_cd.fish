function __fzf_cd -d "Change directory"
    fd --type d | fzf | read -l dirsel

    if not test -z "$dirsel"
        builtin cd "$dirsel"
        commandline -t ""
    end

    commandline -f repaint
end
