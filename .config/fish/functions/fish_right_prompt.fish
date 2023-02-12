function fish_right_prompt -d 'Show non-zero exit status and command duration.'

    # save status of last command
    set -l last_status $status

    # exit if status count was carried over (no command issued)
    if not set -q __fish_prompt_status_generation
        or test $__fish_prompt_status_generation = $status_generation
            return
    end

    # save status call in global variable for next call
    set -g __fish_prompt_status_generation $status_generation

    # print non-zero exit status
    if not contains $last_status 0 141
        echo -n (set_color $fish_color_status)' ['
        echo -n (set_color --bold)$last_status
        echo -n (set_color normal)
        echo -n (set_color $fish_color_status)'] '
    end

    # split command duration in d, h, m, s
    set -l days    (math "$CMD_DURATION / 1000 / 60 / 60 / 24")
    set -l hours   (math "$CMD_DURATION / 1000 / 60 / 60 % 24")
    set -l minutes (math "$CMD_DURATION / 1000 / 60 % 60 ")
    set -l seconds (math "$CMD_DURATION / 1000 % 60")

    # set non-disturbing color
    set_color --dim brblack

    # print any non-zero parts
    if test $days -gt 1
        printf '%.0fd' $days
    end
    if test $hours -gt 1
        printf '%.0fh' $hours
    end
    if test $minutes -gt 1
        printf '%.0fm' $minutes
    end
    if test $seconds -gt 1
        printf '%.0fs\n' $seconds
    end

    # back to normal color
    set_color
end
