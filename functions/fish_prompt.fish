function fish_prompt --description 'write out the prompt'
    set -l term_bg_color black


    set -l cwd_fg_color d6dbdf
    set -l cwd_lock_fg_color a6acaf
    set -l cwd_bg_color 2874a6

    set -l git_branch_fg_color d6dbdf
    set -l git_branch_bg_color 1b4f72
    set -l git_stats_fg_color 7fb3d5

    set -l jobs_fg_color ecf0f1
    set -l jobs_bg_color b03a2e

    # cwd {{{1
    set -l working_dir (pwd)
    set -l working_dir_ind

    if string match "$HOME*" $working_dir > /dev/null
        set working_dir_ind '❖ '
    else
        set working_dir_ind '⯁ '
    end

    if test $working_dir != '/'; and test "$working_dir" != "$HOME"
        set working_dir (basename $working_dir)' '
    else
        set working_dir
    end

    if test ! -w .
        echo -n -s (set_color $cwd_lock_fg_color -b $cwd_bg_color)
    else
        echo -n -s (set_color $cwd_fg_color -b $cwd_bg_color)
    end

    echo -n -s $working_dir_ind (set_color $cwd_fg_color -b $cwd_bg_color) $working_dir

    # git branch {{{1
    set -l next_color $cwd_bg_color
    set -l git_branch (git branch --no-color 2> /dev/null)

    if test $status -eq 0
        # format branch name {{{2
        set git_branch (printf '%s\n' $git_branch | sed -e '/^[^*]/d' -e 's/^* \(.*\)/\1/')
        set next_color $git_branch_bg_color

        # find modified files {{{2
        set -l git_status (git status --porcelain -u)
        set -l git_modified (printf '%s\n' $git_status | grep '^ M' | wc -l)
        if test $git_modified -ne 0
            set git_modified " ⯁ $git_modified"
        else
            set git_modified
        end

        # find untracked files {{{2
        set -l git_untracked (printf '%s\n' $git_status | grep '^??' | wc -l)
        if test $git_untracked -ne 0
            set git_untracked " ◇ $git_untracked"
        else
            set git_untracked
        end

        # find ahead or behind {{{2
        git config --get "branch.$git_branch.merge" >/dev/null 2>&1
        set -l git_ahead_behind
        if test $status -eq 0
            set -l git_ahead_behind_count (git rev-list --count --left-right '@{upstream}...HEAD' 2>/dev/null)
            if test $status -eq 0
                set -l git_ahead (string replace -r '^\d+\s+' '' -- $git_ahead_behind_count)
                if test $git_ahead -ne 0
                    set git_ahead_behind " 🠙$git_ahead"
                end

                set -l git_behind (string replace -r '\s+\d+$' '' -- $git_ahead_behind_count)
                if test $git_behind -ne 0
                    set git_ahead_behind "$git_ahead_behind 🠛$git_behind"
                end
            end
        end

        # find stash count  {{{2
        set -l stash_count (git stash list | wc -l)
        if test $stash_count -ne 0
            set stash_count " 🞊 $stash_count"
        else
            set stash_count
        end

        # display branch {{{2
        echo -n -s (set_color $cwd_bg_color -b $git_branch_bg_color) ''

        if string match '(HEAD detached at*' $git_branch > /dev/null
            set git_branch (printf "$git_branch" | sed -e 's/(HEAD detached at //' -e 's/)//')
            echo -n -s (set_color $git_branch_fg_color -b $git_branch_bg_color) ' ➦ '
        else
            echo -n -s (set_color $git_branch_fg_color -b $git_branch_bg_color) '  '
        end

        echo -n -s (set_color $git_branch_fg_color -b $git_branch_bg_color) $git_branch
        echo -n -s (set_color $git_stats_fg_color -b $git_branch_bg_color) "$git_ahead_behind$git_modified$git_untracked$stash_count "
    end

    if test "$TERM_PROGRAM" != "vscode"
        echo -n -s (set_color $next_color -b $term_bg_color) '' (set_color normal)
    end

    # bkg jobs {{{1
    set -l job_count (jobs | grep stopped | wc -l)
    if test $job_count -ne 0
        if test "$TERM_PROGRAM" != "vscode"
            echo -n -s (set_color $term_bg_color -b $jobs_bg_color) ''
        end

        echo -n -s (set_color $jobs_fg_color -b $jobs_bg_color) " $job_count "

        if test "$TERM_PROGRAM" != "vscode"
            echo -n -s (set_color $jobs_bg_color -b $term_bg_color) ''
        end
    end
    # }}}1

     echo -n -s (set_color normal) ' '
end

# vim:fdm=marker:
