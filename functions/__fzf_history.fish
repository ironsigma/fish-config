function __fzf_history -d "Find in history"
    history merge
    history -z | fzf --read0 | read -lz result
    commandline -- (string trim $result)
    commandline -f repaint
end
