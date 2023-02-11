function fish_right_prompt -d 'Show command duration in human readable format.'

    # split command duration in d, h, m, s
    set -l days    (math "$CMD_DURATION / 1000 / 60 / 60 / 24")
    set -l hours   (math "$CMD_DURATION / 1000 / 60 / 60 % 24")
    set -l minutes (math "$CMD_DURATION / 1000 / 60 % 60 ")
    set -l seconds (math "$CMD_DURATION / 1000 % 60")

    # set non-disturbing color
    set_color grey

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
