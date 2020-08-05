function __fzf_find_files -d "List files and folders"
    begin
        fd | fzf -m | while read -l f; set results $results $f; end
    end

    if test -z "$results"
        commandline -f repaint
        return
    end

    commandline -t ""

    for file in $results
        commandline -it -- (string escape $file)
        commandline -it -- " "
    end

    commandline -f repaint
end
