#!/bin/bash

TOUCHPAD=$(xinput list | grep -oP "Touchpad[ \t]*id=\K\d+")
NAT_SCROLL=$(xinput list-props $TOUCHPAD | grep -oP "Natural Scrolling Enabled \(\K\d+")
TAPPING=$(xinput list-props $TOUCHPAD | grep -oP "Tapping Enabled \(\K\d+")

xinput set-prop $TOUCHPAD $NAT_SCROLL 1
xinput set-prop $TOUCHPAD $TAPPING 1

#xinput set-prop <DEVICE> <PROP> <1/0> 
