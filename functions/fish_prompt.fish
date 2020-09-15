function fish_prompt --description 'write out the prompt'
    # path  {{{1
    set -l working_dir (pwd)

    # Show only last component  {{{1
    if test "$working_dir" = "$HOME"
        set working_dir "~"
    else
        set working_dir (basename $working_dir)
    end

    echo -n -s (set_color bryellow) $working_dir

    # git branch  {{{1
    set -l git_branch (/usr/bin/git branch --no-color 2> /dev/null)
    if test $status -eq 0
        set git_branch (printf '%s\n' $git_branch | /usr/bin/sed -e '/^[^*]/d' -e 's/^* \(.*\)/\1/')

        # find modified files  {{{2
        set -l git_status (/usr/bin/git status --porcelain -u)
        set -l git_modified (printf '%s\n' $git_status | /usr/bin/grep '^ M' | /usr/bin/wc -l)

        if test $git_modified -ne 0
            set git_modified " ✻$git_modified"
        else
            set git_modified
        end

        # find untracked files  {{{2
        set -l git_untracked (printf '%s\n' $git_status | /usr/bin/grep '^??' | /usr/bin/wc -l)
        if test $git_untracked -ne 0
            set git_untracked " ◇$git_untracked"
        else
            set git_untracked
        end

        # find ahead or behind  {{{2
        set -l git_ahead_behind
        /usr/bin/git config --get "branch.$git_branch.merge" >/dev/null 2>&1
        if test $status -eq 0
            set -l git_ahead_behind_count (/usr/bin/git rev-list --count --left-right '@{upstream}...HEAD' 2>/dev/null)
            if test $status -eq 0
                set -l git_ahead (string replace -r '^\d+\s+' '' -- $git_ahead_behind_count)
                if test $git_ahead -ne 0
                    set git_ahead_behind " ⬆$git_ahead"
                end

                set -l git_behind (string replace -r '\s+\d+$' '' -- $git_ahead_behind_count)
                if test $git_behind -ne 0
                    set git_ahead_behind "$git_ahead_behind ⬇$git_behind"
                end
            end
        end

        # find stash count  {{{2
        set -l stash_count (/usr/bin/git stash list | /usr/bin/wc -l)
        if test $stash_count -ne 0
            set stash_count " ≡$stash_count"
        else
            set stash_count
        end

        # add symbol for branch or detached  {{{2
        echo -n (set_color brgreen)
        if string match '(HEAD detached at*' $git_branch > /dev/null
            set git_branch (printf "$git_branch" | /usr/bin/sed -e 's/(HEAD detached at //' -e 's/)//')
            echo -n ' ➦'
        else
            echo -n ' '
        end

        # display branch  {{{2
        echo -n " $git_branch"
        echo -n -s (set_color blue) "$git_ahead_behind$git_modified$git_untracked$stash_count"

        # }}}2
    end

    # bkg jobs  {{{1
    set -l job_count (jobs | /usr/bin/grep stopped | /usr/bin/wc -l)
    if test $job_count -ne 0
        echo -n -s (set_color red) " $job_count"
    end

    echo -n -s (set_color normal) ' › '
    # }}}1
end

# vim: fdm=marker fdl=0 fdc=3
