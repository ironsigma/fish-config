function path --description 'find executable in path or print path'
    if set -q argv[1]
        for arg in $argv
            for p in $PATH
                if test -x "$p/$arg"
                    echo -n "$p/$arg"
                    if test -L "$p/$arg"
                        echo -n -s " -> " (realpath "$p/$arg")
                    end
                    echo ''
                end
            end
        end
    else
        for p in $PATH
            echo $p
        end
    end
end
