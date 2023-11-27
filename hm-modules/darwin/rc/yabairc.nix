{yabai, ...}:

''
#!/usr/bin/env sh

# the scripting-addition must be loaded manually if
# you are running yabai on macOS Big Sur. Uncomment
# the following line to have the injection performed
# when the config is executed during startup.
#
# for this to work you must configure sudo such that
# it will be able to run the command without password
#
# see this wiki page for information:
#  - https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(latest-release)
sudo ${yabai} --load-sa
yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

#需要先手动创建足够的namespace(多次执行 yabai -m space --create)

${yabai} -m space 1 --label work   #work
${yabai} -m space 2 --label term   #alacritty
${yabai} -m space 3 --label editor #jetbrains, vscode...
${yabai} -m space 4 --label misc
${yabai} -m space 5 --label social #telegram,wechat...
${yabai} -m space 6 --label email
${yabai} -m space 7 --label relax
${yabai} -m space 8 --label viewer #chrome,safari,koodo,logseq..
${yabai} -m space 9 --label listener
${yabai} -m space 0 --label adhoc

# apps unmanaged (ignore)
${yabai} -m rule --add app="^($(cat $HOME/.yabai.unmanaged.apps | grep '^' | head -c-1 - | tr '\n' '|'))$" manage=off

${yabai} -m rule --add app="^(Snipaste)$" sticky=on layer=above manage=off
${yabai} -m rule --add title="^(Finder Preferences)$" layer=above manage=off

${yabai} -m rule --add app="^(Safari|Notes|Google Chrome|Firefox)$" space=viewer
${yabai} -m rule --add app="^(Telegram|WeChat)$" space=viewer
${yabai} -m rule --add app="^WeChat$" --add title!="^WeChat\\s*\\(Chats\\)\\s*$" manage=off
${yabai} -m rule --add app="^(WeCom)$" space=work
${yabai} -m rule --add app="^(QQ音乐|迅雷)$" space=misc
${yabai} -m rule --add app="^(kitty)$" space=term
${yabai} -m rule --add app="^Microsoft Outlook$" space=email
${yabai} -m rule --add app="^TencentMeeting$" space=work

${yabai} -m rule --add app="^mpv$" manage=off border=off sticky=on layer=above opacity=1.0 grid=8:8:6:0:2:2

${yabai} -m config focus_follows_mouse off #autoraise, off
echo -n off >$HOME/.yabai.config.focus_follows_mouse

${yabai} -m config \
	mouse_follows_focus on \
	window_placement first_child \
	window_topmost off \
	window_shadow off \
	window_animation_duration 0.0 \
	window_opacity_duration 0.0 \
	active_window_opacity 1.0 \
	normal_window_opacity 0.97 \
	window_opacity on \
	insert_feedback_color 0xaad75f5f \
	active_window_border_color 0xBF775759 \
	normal_window_border_color 0x7f353535 \
	window_border_width 2 \
	window_border_radius 12 \
	window_border_blur on \
	window_border_hidpi on \
	window_border off \
	split_ratio 0.50 \
	split_type auto \
	auto_balance off \
	top_padding 02 \
	left_padding 02 \
	right_padding 02 \
	bottom_padding 02 \
	window_gap 06 \
	layout bsp \
	mouse_modifier fn \
	mouse_action1 move \
	mouse_action2 resize \
	mouse_drop_action swap

# S K E T C H Y B A R  E V E N T S
#we don't query by sketchybar command, which needs yabai start after sketchybar when bootstraping.
#${yabai} -m config external_bar all:0:$(sketchybar --query bar | jq -r '.height')
${yabai} -m config external_bar all:0:32

## listener can query window and space by:
##   yabai -m query --windows --window
##   yabai -m query --spaces --space
${yabai} -m signal --add event=window_focused action="sketchybar -m --trigger window_focus &> /dev/null"
${yabai} -m signal --add event=window_title_changed action="sketchybar -m --trigger title_change &> /dev/null"
${yabai} -m signal --add event=space_changed action="sketchybar -m --trigger space_change &> /dev/null"
${yabai} -m signal --add event=window_resized action="sketchybar -m --trigger window_resize &> /dev/null"

echo "yabai configuration loaded.."

#some references
## https://www.cnblogs.com/kawaihe/p/yabai--mac-de-chuang-kou-ping-pu-guan-li-ruan-jian.html
''
