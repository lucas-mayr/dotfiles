#!/usr/bin/env bash

 #USER=`whoami`
 #PROCESS=spotify
 #PID=`pgrep -o -u $USER $PROCESS`
 #ENVIRON=/proc/$PID/environ
 #if [ -e $ENVIRON ]
 #then
 #    export `grep -z DBUS_SESSION_BUS_ADDRESS $ENVIRON`
 #else
 #    echo "Unable to set DBUS_SESSION_BUS_ADDRESS."
 #    exit 1
 #fi

function help_me()
{
  echo "Usage: $0 [toggle|next|prev]"
}

function next()
{
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next	
}

function prev()
{
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous
}

function toggle()
{
	dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause	
}

case "${1:-}" in
  (next)   next    ;;
  (prev)   prev    ;;
  (toggle) toggle  ;;
  (*)      help_me ;;
esac
