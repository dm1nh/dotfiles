#!/usr/bin/env bash

output_dir=$(xdg-user-dir VIDEOS 2>/dev/null)
mkdir -p "$output_dir"

get_date() {
  date '+%Y%m%d%H%M%S'
}

mkdir -p ~/Videos
if pgrep -f gpu-screen-recorder >/dev/null; then
  notify-send --app-name="Screen Recorder" --icon="camera-video-symbolic" "Recording Stopped" "Stopped" &
  pkill -f gpu-screen-recorder &
else
  notify-send --app-name="Screen Recorder" --icon="camera-video-symbolic" "Recording Started" "Running in background" &
  if [[ "$1" == "--sound" ]]; then
    gpu-screen-recorder -w screen -f 60 -a default_output -a default_input -o "$output_dir/recording_$(get_date).mp4"
    disown
  else
    gpu-screen-recorder -w screen -f 60 -o "$output_dir/recording_$(get_date).mp4"
    disown
  fi
fi
