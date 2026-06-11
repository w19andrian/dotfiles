#!/bin/bash

current=$(powerprofilesctl get)

case "$1" in
    toggle)
        case "$current" in
            power-saver) powerprofilesctl set balanced ;;
            balanced)    powerprofilesctl set performance ;;
            performance) powerprofilesctl set power-saver ;;
        esac
        ;;
    *)
        case "$current" in
            power-saver)  echo '{"text": " Power Saver", "class": "power-saver"}' ;;
            balanced)     echo '{"text": " Balanced", "class": "balanced"}' ;;
            performance)  echo '{"text": " Performance", "class": "performance"}' ;;
        esac
        ;;
esac
