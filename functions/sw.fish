function sw -d 'swap file names' --argument-names left_file right_file
    if test ! -f $left_file
        echo "File '$left_file' not found" >&2
        return 1
    end

    if test ! -f $right_file
        echo "File '$right_file' not found" >&2
        return 1
    end

    set -l temp_file "$left_file.sw__tmp__"


    # move left_file to temp
    command mv $left_file $temp_file > /dev/null 2>&1
    if test $status -ne 0
        echo "Cannot rename '$left_file'" >&2
        return 1
    end

    # move right_file to left_file
    command mv $right_file $left_file > /dev/null 2>&1
    if test $status -ne 0
        echo "Cannot rename '$right_file'" >&2

        command mv $temp_file $left_file > /dev/null 2>&1
        if test $status -ne 0
            echo "Cannot restore '$left_file' left in '$temp_file'" >&2
        end
        return 1
    end

    # move temp to right_file
    command mv $temp_file $right_file > /dev/null 2>&1
    if test $status -ne 0
        echo "Cannot rename '$left_file' to '$right_file" >&2

        command mv $left_file $right_file > /dev/null 2>&1
        if test $status -ne 0
            echo "Cannot restore '$right_file' left in '$left_file'" >&2
            echo "Cannot restore '$left_file' left in '$temp_file'" >&2

        else
            command mv $temp_file $left_file > /dev/null 2>&1
            if test $status -ne 0
                echo "Cannot restore '$left_file' left in '$temp_file'" >&2
            end
        end

        return 1
    end

    echo "$left_file <=> $right_file"
    return 0
end

