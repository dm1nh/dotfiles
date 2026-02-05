case $1 in
--hex)
	output=$(hyprpicker)
	clr=$(echo "$output" | xargs echo -n | tr '[:upper:]' '[:lower:]')
	echo "$clr" | wl-copy
	notify-send --app-name="colorpicker" --icon="color-select-symbolic" "Colorpicker" "Color $clr copied to your system clipboard"
	;;
--rgb)
	output=($(hyprpicker -f rgb))
	clr=$(echo "rgb(${output[0]}, ${output[1]}, ${output[2]})" | xargs echo -n)
	echo "$clr" | wl-copy
	notify-send --app-name="colorpicker" --icon="color-select-symbolic" "Colorpicker" "Color $clr copied to your system clipboard"
	;;
--hsl)
	output=($(hyprpicker -f hsl))
	clr=$(echo "hsl(${output[0]}, ${output[1]}, ${output[2]})" | xargs echo -n)
	echo "$clr" | wl-copy
	notify-send --app-name="colorpicker" --icon="color-select-symbolic" "Colorpicker" "Color $clr copied to your system clipboard"
	;;
esac
