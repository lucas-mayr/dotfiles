#!/usr/bin/env bash

# based on https://github.com/benmaddison/fzf-complete-query/
# We need a pipe, otherwise Mutt goes haywire. 

basepath="$HOME/.config/mutt/scripts"
query="$1"
script="$basepath/query.sh"
pipe="$basepath/query-$$.pipe"
term="alacritty"

cleanup() {
    rm "$pipe"
}

mkdir -p "$(dirname $pipe)"
mkfifo "$pipe"

trap "cleanup" EXIT

$term -e bash -c "exec -a bash $script '$query' >$pipe" &

echo
while true; do
    if read line <$pipe; then
        if [ "$line" == "eof" ]; then
            break
        fi
        echo -n "$line, "
    fi
done
