#!/usr/bin/env bash

get_date() {
	date '+%Y-%m-%d_%H.%M.%S'
}
get_audio_output() {
	pactl list sources | grep 'Name' | grep 'monitor' | cut -d ' ' -f2
}
get_active_monitor() {
	hyprctl monitors -j | gojq -r '.[] | select(.focused == true) | .name'
}

mkdir -p ~/Videos
if pgrep wf-recorder >/dev/null; then
	notify-send --app-name="Record" --icon="camera-video-symbolic" "Recording Stopped" "Stopped" &
	pkill wf-recorder &
else
	notify-send --app-name="Record" --icon="camera-video-symbolic" "Starting recording" 'File will be saved at ~/Videos/recording_'"$(get_date)"'.mp4'
	if [[ "$1" == "--sound" ]]; then
		wf-recorder --pixel-format yuv420p -f '~/Videos/recording_'"$(get_date)"'.mp4' -t --geometry "$(slurp)" --audio="$(get_audio_output)" &
		disown
	elif [[ "$1" == "--fullscreen-sound" ]]; then
		wf-recorder -o $(get_active_monitor) --pixel-format yuv420p -f '~/Videos/recording_'"$(get_date)"'.mp4' --audio="$(get_audio_output)" &
		disown
	elif [[ "$1" == "--fullscreen" ]]; then
		wf-recorder -o $(get_active_monitor) --pixel-format yuv420p -f '~/Videos/recording_'"$(get_date)"'.mp4' &
		disown
	else
		wf-recorder --pixel-format yuv420p -f '~/Videos/recording_'"$(get_date)"'.mp4' --geometry "$(slurp)" &
		disown
	fi
fi
