#!/usr/bin/env bash

get_date() {
  date '+%Y-%m-%d_%H.%M.%S'
}

mkdir -p ~/Pictures

case $1 in
--fullscreen)
  grim - | swappy -f - -o "~/Pictures/screenshot_(get_date).png"
  ;;
--selection)
  grim -g "$(slurp)" - | swappy -f - -o "~/Pictures/screenshot_(get_date).png"
  ;;
esac
