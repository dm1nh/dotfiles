#!/usr/bin/env bash

ags_reload() {
  ags -q
  ags --clear-cache
  ags --init
}

lock() {
  pkill hyprlock
  hyprlock &
}

case $1 in
ags-reload)
  ags_reload
  ;;
lock)
  lock
  ;;
esac
