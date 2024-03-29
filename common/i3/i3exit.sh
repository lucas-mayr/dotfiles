#!/bin/bash
############################################################
# 
############################################################

function lock {
    #i3lock --ignore-empty-password --show-failed-attempts --image $HOME/.i3/samus-mirror.png
    i3lock --ignore-empty-password --show-failed-attempts --image $HOME/.config/i3/lock.png 
}

case "$1" in
    lock)
        lock
        ;;
    logout)
        i3-msg exit
        ;;
    suspend)
        lock && systemctl suspend
        ;;
    reboot)
        systemctl reboot
        ;;
    poweroff)
        systemctl poweroff
        ;;
    *)
        echo "Usage: $0 {lock|logout|suspend|reboot|poweroff}"
        exit 2
esac

exit 0
