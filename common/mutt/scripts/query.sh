cat $HOME/.config/mutt/contacts | fzf --query "$1" --no-height --no-border --multi --with-nth=1 --ansi --preview 'echo {+} | sed -E "s/>\s/>\n/g"' | awk '{ print $1}'

echo "eof"
