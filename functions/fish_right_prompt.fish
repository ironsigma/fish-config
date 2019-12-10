function fish_right_prompt
    # save status
    set -l last_status $status

    # duration
    if test $CMD_DURATION -gt 999
        set -l seconds ''
        set -l minutes ''
        set -l hours ''
        set -l days ''

        set -l cmd_duration (math -s0 $CMD_DURATION / 1000)
        set seconds (math -s0 $cmd_duration % 60)'s '
        if test $cmd_duration -ge 60
            set minutes (math -s0 $cmd_duration % 3600 / 60)'m '
            if test $cmd_duration -ge 3600
                set hours (math -s0 $cmd_duration % 86400 / 3600)'h '
                if test $cmd_duration -ge 86400
                    set days (math -s0 $cmd_duration / 86400)'d '
                end
            end
        end

        if test $minutes != ''
            echo -n -s (set_color bryellow)
        else
            echo -n -s (set_color brblack)
        end

        echo -n -s "$days$hours$minutes$seconds"
    end

    # last command status
    if test $last_status -eq 0
        echo -n -s (set_color brblack) '✔ '
    else
        echo -n -s (set_color red) '✘ '
    end

    # time
    echo -n -s (set_color brblack) (date '+%a %b %-d  %H:%M:%S')
end

