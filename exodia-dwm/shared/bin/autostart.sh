#!/usr/bin/env bash

#####################################
#                                   #
#  @author      : 00xWolf           #
#    GitHub    : @mmsaeed509       #
#    Developer : Mahmoud Mohamed   #
#  﫥  Copyright : Exodia OS         #
#                                   #
#####################################

# Environtment path #
export PATH="${PATH}:/usr/share/exodia/dwm/bin:$HOME/.local/bin"

# dwm config directory #
DWM_DIR="/usr/share/exodia/dwm"

# Kill already running process #
_ps=(picom dunst ksuperkey mpd xfce-polkit xfce4-power-manager)
for _prs in "${_ps[@]}"; do
	if [[ `pidof ${_prs}` ]]; then
		killall -9 ${_prs}
	fi
done

# Fix cursor #
xsetroot -cursor_name left_ptr

# Polkit agent #
/usr/lib/xfce-polkit/xfce-polkit &

# Enable power management #
xfce4-power-manager &

# Enable Super Keys For Menu #
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &

# setup connected monitors #

# No. monitors #
NUM_OF_MONITORS=$(xrandr --listmonitors | grep -c "^ ")

if [[ ${NUM_OF_MONITORS} -ge 1 ]]; 
	then
    	dwmmonitors
fi

# set Keyboard RGB #

~/.config/bspwm/bin/facer_rgb.py -m 0 -z 1 -cR 175 -cB 255 -cG 0 -b 100
sleep 0.3
~/.config/bspwm/bin/facer_rgb.py -m 0 -z 2 -cR 175 -cB 255 -cG 0 -b 100
sleep 0.3
~/.config/bspwm/bin/facer_rgb.py -m 0 -z 3 -cR 175 -cB 255 -cG 0 -b 100
sleep 0.3
~/.config/bspwm/bin/facer_rgb.py -m 0 -z 4 -cR 175 -cB 255 -cG 0 -b 100

# Restore wallpaper #
hsetroot -cover /usr/share/backgrounds/waves_right_colored.png

# Lauch dwmbar #
dwmbar.sh &

# Lauch notification daemon #
dwmdunst.sh

# Lauch compositor #
dwmcomp.sh

# Start mpd #
exec mpd &

# Fix Java problems #
wmname "LG3D"
export _JAVA_AWT_WM_NONREPARENTING=1

# Add your autostart programs here #

# Launch DWM #
while dwm; [ $? -ne 0  ]; do echo "start dwm"; done
