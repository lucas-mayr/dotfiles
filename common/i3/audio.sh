#!/usr/bin/env bash

function list_sinks()
{
  pacmd list-sinks | grep -E 'index:|name:'
}

function switch_sink_default()
{
  echo switching default
  pacmd set-default-sink $1 || echo failed
}

function switch_sink_applications()
{
  echo switching applications
  pacmd list-sink-inputs |
    awk '/index:/{print $2}' |
    xargs -r -I{} pacmd move-sink-input {} $1 ||
      echo failed
}

function switch_sink_kmix_master()
{
  qdbus org.kde.kmix >/dev/null 2>&1 || return 0 # kmix not found

  typeset name mixer
  # get the device name in pulseaudio
  name="$(
    pacmd list-sinks | awk -v search=$1 '
      /index:/{found=$2}
      /* index:/{found=$3}
      /name:/&&found==search{print $2}
    '
  )"
  # format device name to a name in kmix
  name="${name#<}"
  name="${name%>}"
  name="${name//[.-]/_}"
  # grab full path in kmix dbus
  mixer="$( qdbus org.kde.kmix | \grep "/${name}$" )"
  mixer="${mixer#/Mixers/}"
  mixer="${mixer%/*}"
  # get the kmix ids
  name="$( qdbus org.kde.kmix "/Mixers/${mixer}/${name}" org.kde.KMix.Control.id)"
  mixer="$(qdbus org.kde.kmix "/Mixers/${mixer}"         org.kde.KMix.Mixer.id  )"
  echo "set master channel in kmix"
  qdbus org.kde.kmix /Mixers org.kde.KMix.MixSet.setCurrentMaster "$mixer" "$name" >/dev/null || echo failed
}

function switch_sink()
{
  switch_sink_default      "$@"
  switch_sink_applications "$@"
  switch_sink_kmix_master  "$@"
}

# Use a zenity gui to switch audio outputs
function switch_gui()
{
# get current output id, all output ids and the sink names
   current_id=$(pacmd list-sinks | egrep '\* index:' | egrep -o '[0-9]+$')
   ids=( $(pacmd list-sinks | egrep 'index:' | egrep -o '[0-9]+$' | tr '\n' ' ') )
   names=( $(pacmd list-sinks | egrep 'name:' | egrep -o '\..*>$' | tr -d '>' | tr '\n' ' ') )

   zen_pars="--list --radiolist --column '' --column 'ID' --column 'Sink_name'"

# construct the zenity command
   for i in "${!ids[@]}"
   do
      if [ ${ids[$i]} = $current_id ]; then
         zen_pars="$zen_pars TRUE"
      else
         zen_pars="$zen_pars FALSE"
      fi
      zen_pars="$zen_pars ${ids[$i]} ${names[$i]}"
   done

# change the audio sink with the switch_sink function
   new_sink_id=$(zenity $zen_pars || echo "")
   if [ -n $new_sink_id ]; then
      switch_sink $new_sink_id
   fi
}

function help_me()
{
  echo "Usage: $0 [gui|list|<sink name to switch to>]"
}

function master_vol_up()
{
	amixer -D pulse sset Master 5%+
}

function master_vol_down()
{
	amixer -D pulse sset Master 5%-
}

function toggle_mute()
{
	amixer sset Master toggle
}

case "${1:-}" in
  (""|list) list_sinks          ;;
  ([0-9]*)  switch_sink "$@"    ;;
  (gui)     switch_gui          ;;
  (master_up)	master_vol_up   ;;
  (master_down)	master_vol_down ;;
  (toggle_mute)	toggle_mute     ;;
  (*)       help_me             ;;
esac
