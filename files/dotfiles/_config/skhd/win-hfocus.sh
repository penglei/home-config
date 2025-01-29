#!/usr/bin/env bash

function select_window() {
  local floating="$1"
  local all_windows
  all_windows="$(yabai -m query --windows --space)"
  jq -r "first(.[] | select(.[\"is-floating\"] == $floating) | .id)" <<<"$all_windows"
}

function focus() {
  local direction="$1"
  local cur_is_floating="false"
  local filter_tiling="true"

  if [ "$direction" = "west" ]; then
    cur_is_floating="true"
    filter_tiling="false"
  fi

  if ! yabai -m window --focus "$direction"; then
    focused_window="$(yabai -m query --windows --window)"
    if [ "$(jq '."is-floating"' <<<"$focused_window")" = "$cur_is_floating" ]; then
      window_id=$(select_window "$filter_tiling")
      if [ -n "$window_id" ]; then
        yabai -m window --focus "$window_id"
      fi
    else
      yabai -m window --focus "$direction"
    fi
  fi
}

focus "$1"

#TODO

# #cyclic focus stack windows
# ctrl - right : ${yabai} -m query --spaces --space \
#                | ${jq} -re ".index" \
#                | xargs -I{} ${yabai} -m query --windows --space {} \
#                | ${jq} -sre '.[] | map(select(.minimized != 1)) | sort_by(.display, .frame.y, .frame.x, .id) | reverse | nth(index(map(select(."has-focus" == true))) - 1).id'
#                | xargs -I{} ${yabai} -m window --focus {}
# ctrl - left: ${yabai} -m query --spaces --space \
#   | ${jq} -re ".index" \
#   | xargs -I{} ${yabai} -m query --windows --space {} \
#   | ${jq} -sre '.[] | map(select(.minimized != 1)) | sort_by(.display, .frame.y, .frame.y, .id) | nth(index(map(select(."has-focus" == true))) - 1).id' \
#   | xargs -I{} ${yabai} -m window --focus {}
