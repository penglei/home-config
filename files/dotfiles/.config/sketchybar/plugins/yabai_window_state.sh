#!/usr/bin/env sh

has_fullscreen_zoom=$(yabai -m query --windows --window | jq -r '."has-fullscreen-zoom"')

# echo has_fullscreen_zoom:$has_fullscreen_zoom >> $HOME/debug

label=""
case "$has_fullscreen_zoom" in
  true)
    label="F"
  ;;
esac
sketchybar -m --set window_mode label="$label"
#is_floating is-stickey is-topmost has-fullscreen-zoom 

exit 0

update() {
  # This is called for all other events
  WINDOW=$(yabai -m query --windows --window)
  read -r floating split parent fullscreen sticky <<<$(echo "$WINDOW" | jq -rc '.["is-floating", "split-type", "has-parent-zoom", "has-fullscreen-zoom", "is-sticky"]')

  if [[ $floating == "true" ]]; then
    icon="􀶣"
  elif [[ $parent == "true" ]]; then
    icon="􁈔"
  elif [[ $fullscreen == "true" ]]; then
    icon="􀏒"
  elif [[ $split == "vertical" ]]; then
    icon="􀧉"
  elif [[ $split == "horizontal" ]]; then
    icon="􀧋"
  else
    icon="􀏄"
  fi

  sketchybar --set $NAME icon=$icon
}
#https://github.com/FelixKratz/SketchyBar/discussions/12#discussioncomment-1633997
