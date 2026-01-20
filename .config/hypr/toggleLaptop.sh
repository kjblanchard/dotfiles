#!/bin/bash

STATE=$(hyprctl monitors -j | jq -r '.[] | select(.name=="eDP-1") | .disabled')

if [ "$STATE" = "false" ]; then
    hyprctl keyword monitor "eDP-1,disable"
else
    hyprctl keyword monitor "eDP-1,preferred,auto,1"
fi

