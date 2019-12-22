#!/bin/bash


# Custom notification
# -------------------

bell=""
for sound in /usr/share/sounds/freedesktop/stereo/complete.oga \
             /usr/share/sounds/gnome/default/alerts/glass.ogg
do
    if [ -f "$sound" ]
    then
        bell="paplay $sound"
        break
    fi
done

function notify {
    notify-send -i preferences-system-notifications "Pomodoro" "$1" && $bell
}


# Parse command-line arguments
# ----------------------------

# loop on keyword, argument pairs
while [[ $# -gt 0 ]]
do
    case "$1" in

        # general options
        -w|--work)
            work="$2"
            shift
            ;;
        -p|--play)
            play="$2"
            shift
            ;;

        # unknown option
        *)
            echo "Unknown option $1. Exiting."
            exit 0
            ;;

    esac
    shift
done

# default arguments
work=${work:="1500"}
play=${play:="300"}


# Main program
# ------------

notify "Let's go!"

sleep $work && notify "Take a break!"
sleep $play && notify "Back to work!"

sleep $work && notify "Take a break!"
sleep $play && notify "Back to work!"

sleep $work && notify "Take a break!"
sleep $play && notify "Back to work!"

sleep $work && notify "Take a break!"
sleep $play && notify "Done!"
